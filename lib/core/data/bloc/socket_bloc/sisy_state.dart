part of 'sisy_bloc.dart';

abstract class BinanceState extends Equatable {
  @override
  List<Object> get props => [];
}

class BinanceInitial extends BinanceState {}

class BinanceLoading extends BinanceState {}

class BinanceDataReceived extends BinanceState {
  final Map<String, dynamic> data;

  BinanceDataReceived(this.data);

  @override
  List<Object> get props => [data];
}

class BinanceError extends BinanceState {
  final String message;

  BinanceError(this.message);

  @override
  List<Object> get props => [message];
}