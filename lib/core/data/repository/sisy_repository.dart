import 'package:dio/dio.dart';
import 'package:roqqu/core/data/bloc/candle_history_bloc/candle_history_bloc.dart';
import 'package:roqqu/core/data/model/candlestick_model.dart';

import 'package:dio/dio.dart';
import 'package:roqqu/core/data/model/candlestick_model.dart';

class BinanceRepository {
  final Dio _dio;

  BinanceRepository({Dio? dio}) : _dio = dio ?? Dio(); // Ensures _dio is initialized

  Future<List<Candlesticksss>> fetchHistoricalKlines({
    required String symbol,
    required String interval,
    int limit = 500,
  }) async {
    try {
      final response = await _dio.get( // ✅ Use _dio correctly
        'https://api.binance.com/api/v3/klines',
        queryParameters: {
          'symbol': symbol,
          'interval': interval,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        return (response.data as List).map((kline) {
          return Candlesticksss(
            date: DateTime.fromMillisecondsSinceEpoch(kline[0]), // Open time
            open: double.parse(kline[1]),  // Open price
            high: double.parse(kline[2]),  // High price
            low: double.parse(kline[3]),   // Low price
            close: double.parse(kline[4]), // Close price
            volume: double.parse(kline[5]) // Volume
          );
        }).toList();
      } else {
        throw Exception('Failed to load historical klines. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching klines: $e');
    }
  }
}

