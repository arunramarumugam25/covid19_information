import 'package:covid_tracker/components/stats.dart';
import 'package:covid_tracker/services/corona_api_service.dart';
import 'package:covid_tracker/services/geolocation_service.dart';
import 'package:covid_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

import 'components/action_button.dart';
import 'components/error_alert.dart';
import 'components/stack_pie.dart';
import 'models/corono_data.dart';

enum LocationSource { Global, Local, Search }

class Statspage extends StatefulWidget {
  @override
  _StatspageState createState() => _StatspageState();
}

class _StatspageState extends State<Statspage> {
  Future<CoronavirusData> futureCoronavirusData;
  LocationSource locationSource = LocationSource.Local;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData({String countryCode}) async {
    switch (locationSource) {
      case LocationSource.Global:
        futureCoronavirusData = CoronavirusService().getLatestData();
        break;
      case LocationSource.Local:
        Placemark placemark = await LocationService().getPlacemark();
        setState(() {
          futureCoronavirusData = CoronavirusService().getLocationDataFromPlacemark(placemark);
        });
        break;
      case LocationSource.Search:
        if (countryCode != null) {
          futureCoronavirusData = CoronavirusService().getLocationDataFromCountryCode(countryCode);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppBarMainTitle, style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: FutureBuilder<CoronavirusData>(
            future: futureCoronavirusData,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return SpinKitPulse(color: kColourPrimary, size: 80);
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return dataColumn(coronavirusData: snapshot.data);
                  } else if (snapshot.hasError) {
                    return ErrorAlert(
                      errorMessage: snapshot.error.toString(),
                      onRetryButtonPressed: () {
                        setState(() {
                          getData();
                        });
                      },
                    );
                  }
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Column dataColumn({CoronavirusData coronavirusData}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          coronavirusData.date,
          style: kTextStyleDate,
          textAlign: TextAlign.center,
        ),
        Text(
          coronavirusData.locationLabel,
          style: kTextStyleLocationLabel,
          textAlign: TextAlign.center,
        ),
        StackPie(
          totalNumber: coronavirusData.totalNumber,
          sickNumber: coronavirusData.sickNumber,
          recoveredNumber: coronavirusData.recoveredNumber,
          deadNumber: coronavirusData.deadNumber,
        ),
        Stats(
          sickNumber: coronavirusData.sickNumber,
          recoveredNumber: coronavirusData.recoveredNumber,
          deadNumber: coronavirusData.deadNumber,
          sickPercentage: coronavirusData.sickPercentage,
          recoveredPercentage: coronavirusData.recoveredPercentage,
          deadPercentage: coronavirusData.deadPercentage,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ActionButton(
              icon: Icons.location_city,
              onPressed: () {
                setState(() {
                  locationSource = LocationSource.Local;
                  getData();
                });
              },
            ),
            ActionButton(
              icon: Icons.language,
              onPressed: () {
                setState(() {
                  locationSource = LocationSource.Global;
                  getData();
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
