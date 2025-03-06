import 'dart:convert';

class BinanceKlineEvent {
  final String eventType;
  final int eventTime;
  final String symbol;
  final KlineData kline;

  BinanceKlineEvent({
    required this.eventType,
    required this.eventTime,
    required this.symbol,
    required this.kline,
  });

  factory BinanceKlineEvent.fromJson(Map<String, dynamic> json) {
    return BinanceKlineEvent(
      eventType: json['e'],
      eventTime: json['E'],
      symbol: json['s'],
      kline: KlineData.fromJson(json['k']),
    );
  }
}

class KlineData {
  final int startTime;
  final int? closeTime;
  final String? symbol;
  final String? interval;
  final int? firstTradeId;
  final int? lastTradeId;
  final double openPrice;
  final double closePrice;
  final double highPrice;
  final double lowPrice;
  final double baseAssetVolume;
  final int? numberOfTrades;
  final bool? isClosed;
  final double? quoteAssetVolume;
  final double? takerBuyBaseAssetVolume;
  final double? takerBuyQuoteAssetVolume;

  KlineData({
  required  this.startTime,
    this.closeTime,
    this.symbol,
    this.interval,
    this.firstTradeId,
    this.lastTradeId,
   required this.openPrice,
   required this.closePrice,
   required this.highPrice,
   required this.lowPrice,
   required this.baseAssetVolume,
    this.numberOfTrades,
    this.isClosed,
    this.quoteAssetVolume,
    this.takerBuyBaseAssetVolume,
    this.takerBuyQuoteAssetVolume,
  });

  factory KlineData.fromJson(Map<String, dynamic> json) {
    return KlineData(
      startTime: json['t'],
      closeTime: json['T'],
      symbol: json['s'],
      interval: json['i'],
      firstTradeId: json['f'],
      lastTradeId: json['L'],
      openPrice: double.parse(json['o']),
      closePrice: double.parse(json['c']),
      highPrice: double.parse(json['h']),
      lowPrice: double.parse(json['l']),
      baseAssetVolume: double.parse(json['v']),
      numberOfTrades: json['n'],
      isClosed: json['x'],
      quoteAssetVolume: double.parse(json['q']),
      takerBuyBaseAssetVolume: double.parse(json['V']),
      takerBuyQuoteAssetVolume: double.parse(json['Q']),
    );
  }
}
