part of 'quote_cubit.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object> get props => [];
}

class QuoteInitial extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final String quoteText;

  const QuoteLoaded(this.quoteText);

  @override
  List<Object> get props => [quoteText];
}
