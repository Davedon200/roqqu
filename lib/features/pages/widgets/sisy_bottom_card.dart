import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roqqu/core/assets/asset.dart';
import 'package:roqqu/core/utils/colors.dart';
import 'package:roqqu/core/utils/constants.dart';
import 'package:roqqu/core/utils/textstyles.dart';
import 'package:roqqu/features/pages/widgets/chart_card.dart';
import 'package:roqqu/features/pages/widgets/sisy_button.dart';

class SisyBottomCard extends StatefulWidget {
  const SisyBottomCard({super.key});

  @override
  State<SisyBottomCard> createState() => _SisyBottomCardState();
}

class _SisyBottomCardState extends State<SisyBottomCard>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(
        length: 2, vsync: this); // Ensure the length matches your tabs
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
      height: 64,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: SisyButton(
                  width: 171,
                  height: 32,
                  backgroundColor: SisyColors.amarantGreen,
                  onPressed: () {
                    _showModal(context);
                  },
                  child: Text(
                    'Buy',
                    style:
                        SisyTextStyles.bold16.copyWith(color: SisyColors.white),
                  )),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: SisyButton(
                  width: 171,
                  height: 32,
                  backgroundColor: SisyColors.amarantRed,
                  child: Text(
                    'Sell',
                    style:
                        SisyTextStyles.bold16.copyWith(color: SisyColors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows custom height
      builder: (context) {
        return Container(
          height: 608,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: SisyColors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16), // Curved top edges
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 32,
                width: 326,
                decoration: BoxDecoration(
                    color: SisyColors.alignmentColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
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
                  tabs: bottomtab,
                  controller: _controller,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    BuyColumn(),
                    SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BuyColumn extends StatefulWidget {
  const BuyColumn({super.key});

  @override
  State<BuyColumn> createState() => _BuyColumnState();
}

class _BuyColumnState extends State<BuyColumn> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 42.0, right: 41, top: 16),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Ensures even spacing
              children: List.generate(3, (index) {
                return InkWell(
                  onTap: () {
                    setState(() => selectedIndex = index);
                  },
                  child: TimeStampCard(
                    width: 90,
                    bodyText: buycontent[index].toString(),
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
          ),
          textField(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  spacing: 4,
                  children: [
                    Text(
                      'Limit price',
                      style: SisyTextStyles.text12.copyWith(
                        color: SisyColors.textGrey,
                      ),
                    ),
                    SvgPicture.asset(
                      kinfo,
                      height: 10,
                      width: 10,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '0.00 USD',
                  style:
                      SisyTextStyles.text12.copyWith(color: SisyColors.textGrey),
                ),
              )),
          textField(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  spacing: 4,
                  children: [
                    Text(
                      'Amount',
                      style: SisyTextStyles.text12.copyWith(
                        color: SisyColors.textGrey,
                      ),
                    ),
                    SvgPicture.asset(
                      kinfo,
                      height: 10,
                      width: 10,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  '0.00 USD',
                  style:
                      SisyTextStyles.text12.copyWith(color: SisyColors.textGrey),
                ),
              )),
          textField(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  spacing: 4,
                  children: [
                    Text(
                      'Type',
                      style: SisyTextStyles.text12.copyWith(
                        color: SisyColors.textGrey,
                      ),
                    ),
                    SvgPicture.asset(
                      kinfo,
                      height: 10,
                      width: 10,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 4,
                  children: [
                    Text(
                      'Good till canceled',
                      style: SisyTextStyles.text12
                          .copyWith(color: SisyColors.textGrey),
                    ),
                    Icon(
                      Icons.expand_more,
                      size: 12,
                    )
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
            ),
            child: Row(
              spacing: 4,
              children: [
                Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: SisyColors.boxBlack)),
                ),
                Text(
                  'Post Only',
                  style:
                      SisyTextStyles.text12.copyWith(color: SisyColors.textGrey),
                ),
                SvgPicture.asset(
                  kinfo,
                  height: 12,
                  width: 12,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style:
                      SisyTextStyles.text12.copyWith(color: SisyColors.textGrey),
                ),
                Text(
                  '0.00',
                  style:
                      SisyTextStyles.text12.copyWith(color: SisyColors.textGrey),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28),
            child: Container(
              height: 32, // Adjust height as needed
              width: double.infinity, // Adjust width as needed
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    SisyColors.blue,
                    SisyColors.purple,
                    SisyColors.pink
                  ], // Your gradient colors
                  begin: Alignment.topLeft, // Start from top-left
                  end: Alignment.bottomRight, // End at bottom-right
                ),
                borderRadius:
                    BorderRadius.circular(8), // Optional: Add rounded corners
              ),
              child: Center(
                child: Text(
                  'Buy BTC',
                  style: SisyTextStyles.text14.copyWith(color: SisyColors.white),
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            color: SisyColors.divider.withAlpha(70),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 29.0, right: 29),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      orderdetails('Total account value', '0.00',
                          CrossAxisAlignment.start),
                      orderdetails('Open Order', '0.00', CrossAxisAlignment.start)
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 4,
                        children: [
                          Text(
                            'NGN',
                            style: SisyTextStyles.text12
                                .copyWith(color: SisyColors.textGrey),
                          ),
                          Icon(
                            Icons.expand_more,
                            size: 12,
                          )
                        ],
                      ),
                      orderdetails('Available', '0.00', CrossAxisAlignment.end)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 32, 
                width: 80, 
                decoration: BoxDecoration(
                  color: SisyColors.oxfordBlue,
              
                  borderRadius:
                      BorderRadius.circular(8), // Optional: Add rounded corners
                ),
                child: Center(
                  child: Text(
                    'Deposit',
                    style: SisyTextStyles.text14.copyWith(color: SisyColors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column orderdetails(
      String title, String bodytitle, CrossAxisAlignment alignment) {
    return Column(
      spacing: 8,
      crossAxisAlignment: alignment,
      children: [
        Text(
          title,
          style: SisyTextStyles.text12.copyWith(color: SisyColors.textGrey),
        ),
        Text(
          bodytitle,
          style: SisyTextStyles.text12,
        )
      ],
    );
  }

  SizedBox textField(Widget prefixIcon, Widget suffixIcon) {
    return SizedBox(
      height: 40,
      width: 326,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: SisyColors.white,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: SisyColors.boxGrey),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
