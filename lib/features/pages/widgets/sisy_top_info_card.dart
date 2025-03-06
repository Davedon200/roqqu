import 'package:flutter/material.dart';
import 'package:roqqu/core/utils/colors.dart';
import 'package:roqqu/core/utils/constants.dart';
import 'package:roqqu/features/pages/widgets/chart_card.dart';

class TopInfoCard extends StatefulWidget {
  const TopInfoCard({super.key});

  @override
  State<TopInfoCard> createState() => _TopInfoCardState();
}

class _TopInfoCardState extends State<TopInfoCard>
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
      height: 591,
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: SisyColors.alignmentColor,
                borderRadius: BorderRadius.circular(8),
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
                tabs: tab,
                controller: _controller,
              ),
            ),
          ),
          Expanded(
            // Wrap in Expanded to avoid layout issues
            child: TabBarView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ChartData(),
                SizedBox(),
                SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
