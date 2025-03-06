import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roqqu/core/data/bloc/candle_history_bloc/candle_history_bloc.dart';
import 'package:roqqu/core/data/bloc/socket_bloc/sisy_bloc.dart';
import 'package:roqqu/core/data/repository/sisy_repository.dart';

import 'package:roqqu/core/data/sisy_websocket.dart';

import 'package:roqqu/features/pages/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final binanceBloc = BinanceBloc(BinanceWebSocketService());
    final candleBloc = CandleStickHistoryBloc(
        binanceRepository: BinanceRepository(),
        );
    return RestorationScope(
      restorationId: "root",
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BinanceBloc>(
            create: (context) => binanceBloc,
          ),
          BlocProvider<CandleStickHistoryBloc>(
            create: (context) => candleBloc,
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: const SisyphusDashboard(),
          ),
        ),
      ),
    );
  }
}
