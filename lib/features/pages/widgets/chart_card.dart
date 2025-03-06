import 'package:candlesticks/candlesticks.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roqqu/core/assets/asset.dart';
import 'package:roqqu/core/data/bloc/candle_history_bloc/candle_history_bloc.dart';
import 'package:roqqu/core/data/bloc/socket_bloc/sisy_bloc.dart';
import 'package:roqqu/core/data/model/binance_kline_model.dart';
import 'package:roqqu/core/data/model/candlestick_model.dart';
import 'package:roqqu/core/utils/colors.dart';
import 'package:roqqu/core/utils/constants.dart';
import 'package:roqqu/core/utils/textstyles.dart';
import 'package:roqqu/features/pages/widgets/sisy_divider.dart';

class ChartData extends StatefulWidget {
  const ChartData({super.key});

  @override
  State<ChartData> createState() => _ChartDataState();
}

class _ChartDataState extends State<ChartData>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<CandleStickHistoryBloc>().add(
          FetchCandleHistory(symbol: 'BTCUSDT', interval: '1m'),
        );

    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              spacing: 4,
              children: [
                Container(
                  height: 28,
                  width: 43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      'Time',
                      style: SisyTextStyles.text14,
                    ),
                  ),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(6, (index) {
                    return InkWell(
                      onTap: () {
                        setState(() => selectedIndex = index);
                      },
                      child: TimeStampCard(
                        bodyText: timestamp[index].toString(),
                        containerColor: selectedIndex == index
                            ? SisyColors.boxGrey
                            : SisyColors.white,
                        textcolor: selectedIndex == index
                            ? SisyColors.boxBlack
                            : SisyColors.textGrey,
                      ),
                    );
                  }),
                ),
                const Icon(Icons.expand_more),
                SvgPicture.asset(
                  kcandle,
                  height: 20,
                  width: 20,
                ),
                Text('FX',
                    style: SisyTextStyles.text14
                        .copyWith(color: SisyColors.textGrey)),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Divider(
          height: 1,
          color: SisyColors.divider.withAlpha(70),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SvgPicture.asset(
            kdiagonal,
            height: 20,
            width: 20,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Divider(
          height: 1,
          color: SisyColors.divider.withAlpha(70),
        ),
        Expanded(
          child: Row(
            children: [
              SisyDivider(
                height: 1009,
                width: 0.5,
              ),
              Expanded(child: ChartContent()),
            ],
          ),
        )
      ],
    );
  }
}

class ChartContent extends StatelessWidget {
  const ChartContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandleStickHistoryBloc, CandleState>(
        buildWhen: (previous, current) => current is CandleHistoryReceived,
        builder: (context, state) {
          if (state is CandleHistoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CandleHistoryReceived) {
            print('state: ${state.data}');

            if (state.data.isEmpty) {
              return Center(child: Text("No Market Data Available"));
            }

            List<Candle> candles = state.data.map((klineData) {
              return Candle(
                date: klineData.date,
                open: klineData.open,
                high: klineData.high,
                low: klineData.low,
                close: klineData.close,
                volume: klineData.volume,
              );
            }).toList();

            return Candlesticks(candles: candles);
          } else if (state is CandleHistoryError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return Center(child: Text("No Data"));
          }
        });
    // Padding(
    //   padding: const EdgeInsets.only(
    //     left: 9.5,
    //     top: 16,
    //   ),
    //   child: Column(
    //     children: [
    //       SingleChildScrollView(
    //         scrollDirection: Axis.horizontal,
    //         child: Row(
    //           spacing: 16,
    //           children: [
    //             Container(
    //               height: 16.67,
    //               width: 16.67,
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   width: 1,
    //                   color: SisyColors.divider,
    //                 ),
    //                 borderRadius: BorderRadius.circular(4),
    //               ),
    //               child: Icon(
    //                 Icons.expand_more,
    //                 size: 15,
    //               ),
    //             ),
    //             Text(
    //               'BTC/USD',
    //               style: SisyTextStyles.text10.copyWith(
    //                 color: SisyColors.textGrey,
    //               ),
    //             ),
    //             priceaction('O', '30,098,76'),
    //             priceaction('H', '30,098,76'),
    //             priceaction('L', '30,098,76'),
    //             priceaction('C', '30,098,76'),
    //           ],
    //         ),
    //       ),
    //       Image.asset(
    //         kvol,
    //         height: 189,
    //         width: 300,
    //       ),
    //       const SizedBox(
    //         height: 13,
    //       ),
    //       Divider(
    //         height: 0.5,
    //         color: SisyColors.divider.withAlpha(75),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(12.0),
    //         child: Row(
    //           spacing: 6,
    //           children: [
    //             priceaction('Vol(BTC):', '65.254K'),
    //             priceaction('Vol(BTC):', '2.48B'),
    //           ],
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 40,
    //       ),
    //       Image.asset(
    //         kframe,
    //         height: 72,
    //         width: 300,
    //       ),
    //     ],
    //   ),
    // );
  }

  Row priceaction(String text1, String text2) {
    return Row(
      spacing: 4,
      children: [
        Text(
          text1,
          style: SisyTextStyles.text10.copyWith(color: SisyColors.textGrey),
        ),
        Text(
          text2,
          style: SisyTextStyles.text10.copyWith(color: SisyColors.green),
        ),
      ],
    );
  }
}

class CandlestickChart extends StatelessWidget {
  final List<KlineData> candlestickData;

  CandlestickChart(this.candlestickData);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: candlestickData
                    .asMap()
                    .entries
                    .map((e) =>
                        FlSpot(e.key.toDouble(), e.value.closePrice.toDouble()))
                    .toList(),
                isCurved: false,
                color: Colors.green,
                barWidth: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeStampCard extends StatelessWidget {
  final Color containerColor;
  final Color textcolor;
  final double height;
  final double width;
  final String bodyText;
  const TimeStampCard(
      {super.key,
      required this.containerColor,
      required this.textcolor,
      required this.bodyText,
      this.height = 28,
      this.width = 43});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: containerColor,
      ),
      child: Center(
        child: Text(
          bodyText,
          style: SisyTextStyles.text14.copyWith(
            color: textcolor,
          ),
        ),
      ),
    );
  }
}
