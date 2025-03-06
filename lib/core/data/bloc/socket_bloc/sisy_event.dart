part of 'sisy_bloc.dart';

abstract class BinanceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ConnectToWebSocket extends BinanceEvent {
  final String symbol;
  final String streamType; // "kline_1m" or "depth"

  ConnectToWebSocket(this.symbol, this.streamType);
}

class DisconnectWebSocket extends BinanceEvent {}
