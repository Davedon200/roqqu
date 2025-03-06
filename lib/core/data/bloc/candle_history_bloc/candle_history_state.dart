part of 'candle_history_bloc.dart';

abstract class CandleState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial loading state
class CandleHistoryLoading extends CandleState {}

// Data received successfully
class CandleHistoryReceived extends CandleState {
  final List<Candlesticksss> data;

  CandleHistoryReceived(this.data);

  @override
  List<Object?> get props => [data];
}

// Error state
class CandleHistoryError extends CandleState {
  final String message;

  CandleHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}

