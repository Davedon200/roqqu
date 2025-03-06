import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceWebSocketService {
  WebSocketChannel? _channel;

  Stream<Map<String, dynamic>> connect(String symbol, String streamType) {
    final url = 'wss://stream.binance.com:9443/ws/${symbol.toLowerCase()}@$streamType';
    _channel = WebSocketChannel.connect(Uri.parse(url));

    return _channel!.stream.map((event) {
      return jsonDecode(event);
    });
  }

  void disconnect() {
    _channel?.sink.close();
  }
}
