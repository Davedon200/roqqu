import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqqu/core/data/model/candlestick_model.dart';

import 'package:roqqu/core/data/repository/sisy_repository.dart';
import 'package:roqqu/core/data/sisy_websocket.dart';

part 'sisy_event.dart';
part 'sisy_state.dart';

class BinanceBloc extends Bloc<BinanceEvent, BinanceState> {
  final BinanceWebSocketService _webSocketService;

  BinanceBloc(this._webSocketService) : super(BinanceInitial()) {
    on<ConnectToWebSocket>((event, emit) async {
      emit(BinanceLoading());
      try {
        _webSocketService.connect(event.symbol, event.streamType).listen(
          (data) => add(_NewWebSocketData(data)), // Handle new messages
          onError: (error) => add(DisconnectWebSocket()), // Handle errors
        );
      } catch (e) {
        emit(BinanceError(e.toString()));
      }
    });

    on<_NewWebSocketData>((event, emit) {
      emit(BinanceDataReceived(event.data));
    });

    on<DisconnectWebSocket>((event, emit) {
      _webSocketService.disconnect();
      emit(BinanceInitial());
    });
  }
}

class _NewWebSocketData extends BinanceEvent {
  final Map<String, dynamic> data;

  _NewWebSocketData(this.data);
}