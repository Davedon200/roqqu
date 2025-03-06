import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqqu/core/data/model/candlestick_model.dart';
import 'package:roqqu/core/data/repository/sisy_repository.dart';
import 'package:roqqu/core/data/sisy_websocket.dart';

part 'candle_history_state.dart';
part 'candle_history_event.dart';

class CandleStickHistoryBloc
    extends Bloc<CandleStickHistoryEvent, CandleState> {
  final BinanceRepository binanceRepository;

  CandleStickHistoryBloc({required this.binanceRepository})
      : super(CandleHistoryLoading()) {
    on<FetchCandleHistory>(_onFetchCandleHistory);
    on<BinanceDataReceived>(_onBinanceDataReceived);
  }

  // Fetch initial historical candlestick data
  Future<void> _onFetchCandleHistory(
      FetchCandleHistory event, Emitter<CandleState> emit) async {
    emit(CandleHistoryLoading());
    try {
      final candles = await binanceRepository.fetchHistoricalKlines(
          symbol: event.symbol, interval: event.interval);

      emit(CandleHistoryReceived(candles));
    } catch (e) {
      emit(CandleHistoryError("Failed to load historical data"));
    }
  }

  // Handle Binance WebSocket updates
  void _onBinanceDataReceived(
      BinanceDataReceived event, Emitter<CandleState> emit) {
    if (state is CandleHistoryReceived) {
      final List<Candlesticksss> existingCandles =
          List.from((state as CandleHistoryReceived).data);

      // Extract kline data
      final kline = event.data['k'];

      // Convert Binance Kline data to Candle model
      Candlesticksss newCandle = Candlesticksss(
        date: DateTime.fromMillisecondsSinceEpoch(kline['t']),
        open: double.parse(kline['o']),
        high: double.parse(kline['h']),
        low: double.parse(kline['l']),
        close: double.parse(kline['c']),
        volume: double.parse(kline['v']),
      );

      // If the last candle timestamp matches, update it; otherwise, add a new candle
      if (existingCandles.isNotEmpty &&
          existingCandles.last.date == newCandle.date) {
        existingCandles[existingCandles.length - 1] = newCandle;
      } else {
        existingCandles.add(newCandle);
      }

      // Keep only the last 100 candles for performance optimization
      if (existingCandles.length > 100) {
        existingCandles.removeAt(0);
      }

      // Emit updated state
      emit(CandleHistoryReceived(existingCandles));
    }
  }
}

class Candlesticksss {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  Candlesticksss({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });
}
