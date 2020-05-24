import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kAppBarMainTitle = 'Coronavirus Tracker';

final kNumberFormat = NumberFormat('#,##0');

final kColourPrimary = Colors.cyan[400];
final kColourBackground = Colors.lightGreen[200];

final kColourPieSick = Colors.red[700];
final kColourPieRecovered = Colors.lightGreen[800];
final kColourPieDead = Colors.black87;

final kColourAlertBackground = Colors.cyan[700];

const kTextStyleAppBar = TextStyle(
  fontFamily: 'Courier-Prime',
);
const kTextStyleDate = TextStyle(
  fontFamily: 'Courier-Prime',
  fontSize: 21.0,
);
const kTextStyleLocationLabel = TextStyle(
  fontFamily: 'Courier-Prime-Bold',
  fontSize: 32.0,
);
const kTextStyleTotalLabel = TextStyle(
  fontFamily: 'Courier-Prime',
  fontSize: 21.0,
);
const kTextStyleTotalNumber = TextStyle(
  fontFamily: 'Courier-Prime-Bold',
  fontSize: 32.0,
);
const kTextStyleStats = TextStyle(
  fontFamily: 'Courier-Prime-Bold',
  fontSize: 21.0,
);
const kTextStyleAlertTitle = TextStyle(
  fontFamily: 'Courier-Prime-Bold',
  fontSize: 27,
  color: Colors.white,
);
const kTextStyleAlertText = TextStyle(
  fontFamily: 'Courier-Prime',
  fontSize: 18,
  color: Colors.white,
);
const kTextStyleAlertButton = TextStyle(
  fontFamily: 'Courier-Prime-Bold',
  fontSize: 22,
  color: Colors.white,
);
