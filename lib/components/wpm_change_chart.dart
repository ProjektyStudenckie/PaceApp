import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pace_app/constants.dart';
import 'package:pace_app/repository/models/stats.dart';

import 'gradient_container.dart';

class WPMChangeChart extends StatefulWidget {
  final List<Stats> allStats;

  WPMChangeChart(this.allStats);

  @override
  _WPMChangeChartState createState() => _WPMChangeChartState();
}

class _WPMChangeChartState extends State<WPMChangeChart> {
  List<Color> gradientColors = [
    const Color(0xffa35646),
    const Color(0xffe2938a),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.40,
      child: GradientContainer(
        accentColor: kDarkRed,
        child: Column(
          children: [
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
                mainData(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: false,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return "0";
              case 20:
                return "20";
              case 40:
                return "40";
              case 60:
                return "60";
              case 80:
                return "80";
              case 100:
                return "100";
              case 120:
                return "120";
              case 140:
                return "140";
              case 160:
                return "160";
              case 180:
                return "180";
              case 200:
                return "200";
              case 220:
                return "220";
              case 240:
                return "240";
              case 260:
                return "260";
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Colors.blueGrey, width: 1)),
      minX: 0,
      maxX: widget.allStats.length.toDouble() - 1,
      minY: 0,
      maxY: getUpperBoundary().toDouble() + 10,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = widget.allStats.length-1; i >= 0; i--)
              FlSpot(-i.toDouble() + widget.allStats.length-1, widget.allStats[i].wpm)
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  double getLowestWPM() {
    double minWPM = double.maxFinite;

    for (int i = 0; i < widget.allStats.length; i++) {
      if (widget.allStats[i].wpm < minWPM) {
        minWPM = widget.allStats[i].wpm;
      }
    }

    return minWPM;
  }

  double getHighestWPM() {
    double maxWPM = 0;

    for (int i = 0; i < widget.allStats.length; i++) {
      if (widget.allStats[i].wpm > maxWPM) {
        maxWPM = widget.allStats[i].wpm;
      }
    }

    return maxWPM;
  }

  int getUpperBoundary() {
    double highestWPM = getHighestWPM();
    highestWPM /= 10;

    return highestWPM.ceil() * 10;
  }

  int getLowerBoundary() {
    double lowestWPM = getLowestWPM();
    lowestWPM /= 10;

    return lowestWPM.floor() * 10;
  }

  int getMediumValue() {
    int sum = getUpperBoundary() + getLowerBoundary();

    return (sum ~/ 2);
  }
}
