import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roqqu/core/data/bloc/socket_bloc/sisy_bloc.dart';
import 'package:roqqu/features/pages/widgets/sisy_bottom_card.dart';
import 'package:roqqu/features/pages/widgets/sisy_order_card.dart';
import 'package:roqqu/features/pages/widgets/sisy_top_info_card.dart';
import 'package:roqqu/features/pages/widgets/sisy_pair_card.dart';
import 'package:roqqu/features/pages/widgets/sisy_simple_appbar.dart';

class SisyphusDashboard extends StatefulWidget {
  const SisyphusDashboard({super.key});

  @override
  State<SisyphusDashboard> createState() => _SisyphusDashboardState();
}

class _SisyphusDashboardState extends State<SisyphusDashboard> {
  @override
  void initState() {
    super.initState();
   
    
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SisyAppBar(),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            spacing: 8,
            children: [
              PairCard(),
              TopInfoCard(),
              OrderCard(),
              SisyBottomCard(),
            ],
          ),
        ),
      )),
    );
  }
}
