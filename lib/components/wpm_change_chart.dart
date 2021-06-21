import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    print("Len: ${widget.allStats.length}");

    print("highest: ${getHighestWPM()}");
    print("lowest: ${getLowestWPM()}");
    print("highest b: ${getUpperBoundary()}");
    print("lowest b: ${getLowerBoundary()}");

    return AspectRatio(
      aspectRatio: 1.40,
      child: GradientContainer(
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
          // reservedSize: 22,
          // getTextStyles: (value) => const TextStyle(
          //     color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 16),
          // getTitles: (value) {
          //   switch (value.toInt()) {
          //     case 2:
          //       return 'MAR';
          //     case 5:
          //       return 'JUN';
          //     case 8:
          //       return 'SEP';
          //   }
          //   return '';
          // },
          //margin: 8,
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
            for (int i = 0; i < widget.allStats.length; i++)
              FlSpot(i.toDouble(), widget.allStats[i].wpm)

            // FlSpot(8, 4),
            // FlSpot(9.5, 3),
            // FlSpot(11, 4),
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
