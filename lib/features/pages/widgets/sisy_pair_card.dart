import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roqqu/core/assets/asset.dart';
import 'package:roqqu/core/data/bloc/socket_bloc/sisy_bloc.dart';
import 'package:roqqu/core/data/model/binance_kline_model.dart';
import 'package:roqqu/core/utils/colors.dart';
import 'package:roqqu/core/utils/textstyles.dart';
import 'package:roqqu/features/pages/widgets/sisy_divider.dart';

class PairCard extends StatefulWidget {
  const PairCard({super.key});

  @override
  State<PairCard> createState() => _PairCardState();
}

class _PairCardState extends State<PairCard> {
  @override
  void initState() {
    super.initState();
    context.read<BinanceBloc>().add(ConnectToWebSocket(
          "btcusdt",
          "kline_1m",
        ));
  }

  @override
  void dispose() {
    context.read<BinanceBloc>().add(DisconnectWebSocket());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        height: 126,
        width: double.infinity,
        color: SisyColors.white,
        child:
            BlocBuilder<BinanceBloc, BinanceState>(builder: (context, state) {
          if (state is BinanceLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BinanceDataReceived) {
            print('state $state.data');

            if (state.data == null || state.data!['k'] == null) {
              return Center(child: Text("No Data Available"));
            }

            final klineData = KlineData.fromJson(state.data["k"]);

            final closingPrice = klineData.closePrice.toString();

            double openPrice = klineData.openPrice;
            double closePrice = klineData.closePrice;
            double highPrice = klineData.highPrice;
            double lowPrice = klineData.lowPrice;

            // Determine color based on price movement
            Color priceColor = closePrice > openPrice
                ? SisyColors.amarantGreen // Price increased
                : closePrice < openPrice
                    ? SisyColors.amarantRed // Price decreased
                    : SisyColors.textBlack; // No change
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none, // Ensures proper overlap
                            children: [
                              SvgPicture.asset(
                                kBitcoin,
                                width: 24,
                                height: 24,
                              ),
                              Positioned(
                                left: 19, // Adjust for lapping effect
                                child: SvgPicture.asset(
                                  kdollar,
                                  width:
                                      24, // Slightly smaller to show layering
                                  height: 24,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 24), // Spacing after icons
                      Text(
                        'BTC/USDT',
                        style: SisyTextStyles.text18,
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.expand_more),
                      const SizedBox(width: 16),
                      Text(
                        "\$$closingPrice",
                        style: SisyTextStyles.text18.copyWith(
                          color: priceColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 16,
                      children: [
                        RateCard(
                          icon: kclock,
                          bodyText:
                              '${klineData.closePrice} (${((klineData.closePrice - klineData.openPrice) / klineData.openPrice * 100).toStringAsFixed(2)}%)',
                          titleText: '24h change',
                          color: priceColor,
                        ),
                        RateCard(
                          icon: karrowup,
                          bodyText: highPrice.toStringAsFixed(2),
                          titleText: '24h high',
                          color: SisyColors.textBlack,
                        ),
                        RateCard(
                          icon: karrowdown,
                          bodyText: lowPrice.toStringAsFixed(2),
                          titleText: '24h low',
                          color: SisyColors.textBlack,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else if (state is BinanceError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return Center(child: Text("No Data"));
          }
        }));
  }
}

class RateCard extends StatelessWidget {
  final String icon;
  final String? bodyText;
  final String? titleText;
  final Color? color;

  const RateCard(
      {super.key,
      this.bodyText,
      required this.icon,
      this.titleText,
      this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Row(
                spacing: 4,
                children: [
                  SvgPicture.asset(icon),
                  Text(
                    titleText.toString(),
                    style: SisyTextStyles.text12
                        .copyWith(color: SisyColors.textGrey),
                  )
                ],
              ),
              Text(
                bodyText.toString(),
                style: SisyTextStyles.bold14.copyWith(color: color),
              )
            ],
          ),
          SisyDivider(
              height: 48, width: 1, color: SisyColors.textGrey.withAlpha(70)),
        ],
      ),
    );
  }
}
