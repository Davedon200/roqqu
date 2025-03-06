import 'package:flutter/material.dart';
import 'package:roqqu/core/utils/colors.dart';
import 'package:roqqu/core/utils/constants.dart';
import 'package:roqqu/core/utils/textstyles.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
        length: 3, vsync: this); // Ensure the length matches your tabs
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SisyColors.white,
      height: 350,
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16),
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: SisyColors.alignmentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: TabBar(
                indicatorColor: Colors.transparent,
                dividerColor: SisyColors.white,
                indicator: BoxDecoration(
                  color: SisyColors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                unselectedLabelColor: SisyColors.textGrey,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.all(5),
                labelColor: SisyColors.textBlack,
                tabs: ordertab,
                controller: _controller,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No Open Orders',
                          style: SisyTextStyles.text18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 54, left: 45, right: 45),
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
                            style: SisyTextStyles.text14
                                .copyWith(color: SisyColors.textGrey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No Open Position',
                          style: SisyTextStyles.text18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 54, left: 45, right: 45),
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
                            style: SisyTextStyles.text14
                                .copyWith(color: SisyColors.textGrey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(),
                ]),
          ),
        ],
      ),
    );
  }
}
