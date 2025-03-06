class Candlestick {
  final int openTime;
  final double openPrice;
  final double highPrice;
  final double lowPrice;
  final double closePrice;
  final double volume;
  final int closeTime;
  final double quoteAssetVolume;
  final int numberOfTrades;
  final double takerBuyBaseAssetVolume;
  final double takerBuyQuoteAssetVolume;

  Candlestick({
    required this.openTime,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.closePrice,
    required this.volume,
    required this.closeTime,
    required this.quoteAssetVolume,
    required this.numberOfTrades,
    required this.takerBuyBaseAssetVolume,
    required this.takerBuyQuoteAssetVolume,
  });

  factory Candlestick.fromJson(List<dynamic> json) {
    return Candlestick(
      openTime: json[0],
      openPrice: double.parse(json[1]),
      highPrice: double.parse(json[2]),
      lowPrice: double.parse(json[3]),
      closePrice: double.parse(json[4]),
      volume: double.parse(json[5]),
      closeTime: json[6],
      quoteAssetVolume: double.parse(json[7]),
      numberOfTrades: json[8],
      takerBuyBaseAssetVolume: double.parse(json[9]),
      takerBuyQuoteAssetVolume: double.parse(json[10]),
    );
  }

  static List<Candlestick> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Candlestick.fromJson(json)).toList();
  }
}
