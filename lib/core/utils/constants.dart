import 'package:flutter/material.dart';
import 'package:roqqu/core/utils/textstyles.dart';

List<String> menuList = ["Exchange", "Wallets", "Roqqu Hub", "Log Out"];

enum TimeStamp {
  hour1,
  hour2,
  hour3,
  day,
  week,
  month,
}

List<Widget> tab = [
  Tab(
    child: Text(
      "Charts",
      textAlign: TextAlign.center,
      style: SisyTextStyles.text14.copyWith(
        fontSize: 12,
      ),
    ),
  ),
  Tab(
    child: Text(
      "Orderbook",
      textAlign: TextAlign.center,
      style: SisyTextStyles.text14.copyWith(
        fontSize: 12,
      ),
    ),
  ),
  Tab(
    child: Text(
      "Recent trades",
      textAlign: TextAlign.center,
      style: SisyTextStyles.text14.copyWith(
        fontSize: 12,
      ),
    ),
  ),
];

List<Widget> ordertab = [
  Tab(
    child: Text(
      "Open Orders",
      textAlign: TextAlign.center,
      style: SisyTextStyles.text14,
    ),
  ),
  Tab(
    child: Text(
      "Position",
      textAlign: TextAlign.center,
      style: SisyTextStyles.text14,
    ),
  ),
  Tab(
    child: Text(
      "Order Book",
      textAlign: TextAlign.center,
      style: SisyTextStyles.text14,
    ),
  ),
];
List<Widget> bottomtab = [
  Tab(
    child: Text(
      "Buy",
      textAlign: TextAlign.center,
      style: SisyTextStyles.text14,
    ),
  ),
  Tab(
    child: Text(
      "Sell",
      textAlign: TextAlign.center,
      style: SisyTextStyles.text14,
    ),
  ),
];

List<String> timestamp = [
  '1H',
  '2H',
  '4H',
  '1D',
  '1W',
  '1M',
];
List<String> buycontent = [
  'Limit',
  'Market',
  'Stop-Limit',
];

