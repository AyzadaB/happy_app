import 'package:hive/hive.dart';

part 'quote_model.g.dart';

@HiveType(typeId: 2)
class QuoteModel extends HiveObject {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final String author; // Эгер цитаталарда авторлор болсо

  QuoteModel({required this.text, this.author = 'Белгисиз'});
}
