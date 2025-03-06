part of 'candle_history_bloc.dart';

abstract class CandleStickHistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Fetch historical data event
class FetchCandleHistory extends CandleStickHistoryEvent {
  final String symbol;
  final String interval;

  FetchCandleHistory({required this.symbol, required this.interval});

  @override
  List<Object?> get props => [symbol, interval];
}

// Real-time Binance WebSocket event
class BinanceDataReceived extends CandleStickHistoryEvent {
  final Map<String, dynamic> data;

  BinanceDataReceived({required this.data});

  @override
  List<Object?> get props => [data];
}