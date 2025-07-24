import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happy_app/core/features/quote/data/quote_model.dart';
import 'package:hive/hive.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  final Box<QuoteModel> _quoteBox;
  final Box<dynamic> _appSettingsBox; // Акыркы жаңыртылган күндү сактоо үчүн

  static const String _lastUpdateDateKey = 'lastQuoteUpdateDate';
  static const String _currentQuoteKey = 'currentDailyQuote';

  QuoteCubit(this._quoteBox, this._appSettingsBox) : super(QuoteInitial()) {
    _initQuotes();
    _loadDailyQuote();
  }

  void _initQuotes() {
    if (_quoteBox.isEmpty) {
      // Бул жерге өз цитаталарыңызды кошуңуз
      final List<QuoteModel> predefinedQuotes = [
        QuoteModel(
          text:
              '1. Happiness is not a destination, but a journey. Notice the joy in every step',
        ),
        QuoteModel(
          text: 'Sometimes all it takes is a deep breath to feel happiness',
        ),
        QuoteModel(
          text:
              'The brightest moments are found in simple things: a smile, morning light, a warm cup of tea',
        ),
        QuoteModel(
          text:
              'Happiness is the ability to see beauty in everyday little things',
        ),
        QuoteModel(text: 'Gratitude for small joys multiplies happiness'),
        QuoteModel(
          text:
              'Pay attention to the sounds around you — birds singing, leaves rustling, friends laughing',
        ),
        QuoteModel(
          text: ' Write down moments of joy so they are always with you',
        ),
        QuoteModel(
          text: 'A smile given to you can be the start of a happy day',
        ),
        QuoteModel(text: 'Giving happiness means noticing happiness in others'),
        QuoteModel(
          text: 'Let your eyes be open to the light, even if the day is cloudy',
        ),
        QuoteModel(
          text: 'One breath of fresh air can fill your heart with joy',
        ),
        QuoteModel(
          text: 'Happiness is when your soul sings from simple pleasures',
        ),
        QuoteModel(
          text:
              'Don’t wait for a big celebration — small victories brighten life',
        ),
        QuoteModel(
          text:
              'Learn to see happiness in every day, even if it starts with a cup of coffee',
        ),
        QuoteModel(
          text:
              'Moments of happiness are pieces of a puzzle that make the picture of your life',
        ),
      ];
      _quoteBox.addAll(predefinedQuotes);
    }
  }

  void _loadDailyQuote() {
    final DateTime? lastUpdateDate =
        _appSettingsBox.get(_lastUpdateDateKey) as DateTime?;
    final DateTime now = DateTime.now();

    // Эгер дата сакталбаса же акыркы жаңыртуу кечээ болгон болсо
    if (lastUpdateDate == null || !isSameDay(lastUpdateDate, now)) {
      // Жаңы цитатаны тандоо
      if (_quoteBox.isNotEmpty) {
        final List<QuoteModel> allQuotes = _quoteBox.values.toList();
        final QuoteModel newQuote =
            allQuotes[now.day %
                allQuotes.length]; // Күндүн номерине жараша цитатаны тандоо

        _appSettingsBox.put(
          _currentQuoteKey,
          newQuote.text,
        ); // Учурдагы цитатаны сактоо
        _appSettingsBox.put(
          _lastUpdateDateKey,
          DateTime(now.year, now.month, now.day),
        ); // Күндү сактоо (убакытсыз)
        emit(QuoteLoaded(newQuote.text));
      } else {
        emit(
          const QuoteLoaded('Цитаталар жок.'),
        ); // Эгер цитаталар кутучасы бош болсо
      }
    } else {
      // Эгер буга чейин бүгүнкү цитата тандалган болсо
      final String? currentQuoteText =
          _appSettingsBox.get(_currentQuoteKey) as String?;
      if (currentQuoteText != null) {
        emit(QuoteLoaded(currentQuoteText));
      } else if (_quoteBox.isNotEmpty) {
        // Эгерде цитата сакталбаса, бирок Hive'да цитаталар бар болсо (биринчи жолу ачылганда)
        final List<QuoteModel> allQuotes = _quoteBox.values.toList();
        final QuoteModel newQuote = allQuotes[now.day % allQuotes.length];
        _appSettingsBox.put(_currentQuoteKey, newQuote.text);
        emit(QuoteLoaded(newQuote.text));
      } else {
        emit(const QuoteLoaded('Цитаталар жок.'));
      }
    }
  }

  // Эки дата бир күнгө туура келеби же жокпу текшерүүчү жардамчы функция
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
