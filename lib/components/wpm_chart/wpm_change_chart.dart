import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pace_app/components/wpm_chart/wpm_chart_extra_data.dart';
import 'package:pace_app/components/wpm_chart/wpm_chart_main_data.dart';
import 'package:pace_app/constants.dart';
import 'package:pace_app/repository/models/stats.dart';

import '../gradient_container.dart';

class WPMChangeChart extends StatefulWidget {
  final List<Stats> allStats;

  WPMChangeChart(this.allStats);

  @override
  _WPMChangeChartState createState() => _WPMChangeChartState();
}

class _WPMChangeChartState extends State<WPMChangeChart> {
  var showGross = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.30,
      child: GradientContainer(
        accentColor: kDarkRed,
        child: Stack(children: [
          Column(
            children: [
              SizedBox(height: 10),
              Text(
                "WPM Over time",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Expanded(
                child: LineChart(
                  showGross ? extraData(widget.allStats) : mainData(widget.allStats),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              splashRadius: 20,
                onPressed: () {
                  setState(() {
                    showGross = !showGross;
                  });
                },
                icon: Icon(showGross ? Icons.remove : Icons.add)),
          )
        ]),
      ),
    );
  }
}

double getLowestWPM(List<Stats> allStats) {
  double minWPM = double.maxFinite;

  for (int i = 0; i < allStats.length; i++) {
    if (allStats[i].wpm < minWPM) {
      minWPM = allStats[i].wpm;
    }
  }

  return minWPM;
}

double getHighestWPM(List<Stats> allStats) {
  double maxWPM = 0;

  for (int i = 0; i < allStats.length; i++) {
    if (allStats[i].wpm > maxWPM) {
      maxWPM = allStats[i].wpm;
    }
  }

  return maxWPM;
}

int getUpperBoundary(List<Stats> allStats) {
  double highestWPM = getHighestWPM(allStats);
  highestWPM /= 10;

  return highestWPM.ceil() * 10;
}

int getLowerBoundary(List<Stats> allStats) {
  double lowestWPM = getLowestWPM(allStats);
  lowestWPM /= 10;

  return lowestWPM.floor() * 10;
}

int getMediumValue(List<Stats> allStats) {
  int sum = getUpperBoundary(allStats) + getLowerBoundary(allStats);

  return (sum ~/ 2);
}
