import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class CoronavirusData {
  final String date;
  final String locationLabel;
  final int totalNumber;
  final int recoveredNumber;
  final int deadNumber;
  final int sickNumber;
  final double sickPercentage;
  final double recoveredPercentage;
  final double deadPercentage;

  CoronavirusData(
      {@required this.date,
      @required this.locationLabel,
      @required this.totalNumber,
      @required this.recoveredNumber,
      @required this.deadNumber,
      @required this.sickNumber,
      @required this.sickPercentage,
      @required this.recoveredPercentage,
      @required this.deadPercentage});

  factory CoronavirusData.formatted({
    Map<String, dynamic> json,
    String country,
    String province,
  }) {
    int totalNumber = json['latest']['confirmed'];
    int recoveredNumber = json['latest']['recovered'];
    int deadNumber = json['latest']['deaths'];
    if (totalNumber == 0) {
      throw Exception('No confirmed cases in your area.');
    }
    int sickNumber = totalNumber - recoveredNumber - deadNumber;
    return CoronavirusData(
      date: DateFormat('EEEE d MMMM y').format(DateTime.now()),
      locationLabel: province == null ? country : '$country, $province',
      totalNumber: totalNumber,
      recoveredNumber: recoveredNumber,
      deadNumber: deadNumber,
      sickNumber: sickNumber,
      sickPercentage: sickNumber * 100.0 / totalNumber,
      recoveredPercentage: recoveredNumber * 100.0 / totalNumber,
      deadPercentage: deadNumber * 100.0 / totalNumber,
    );
  }
}
