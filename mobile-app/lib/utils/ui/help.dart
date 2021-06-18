import 'package:app/models/pollutant.dart';
import 'package:app/utils/ui/pm.dart';
import 'package:app/widgets/help/aqi_index.dart';
import 'package:app/widgets/help/pollutant.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/app_constants.dart';

Widget getHelpPage(String name) {
  if (name.trim().toLowerCase() ==
      '${PollutantConstants.pm2_5.toLowerCase()}') {
    return PollutantDialog(pollutantDetails(name));
  } else if (name.trim().toLowerCase() ==
      '${PollutantConstants.pm10.toLowerCase()}') {
    return PollutantDialog(pollutantDetails(name));
  } else {
    return AQI_Dialog();
  }
}
