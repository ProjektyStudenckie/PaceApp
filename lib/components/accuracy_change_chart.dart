import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pace_app/constants.dart';
import 'package:pace_app/repository/models/stats.dart';

import 'gradient_container.dart';

class AccuracyChangeChart extends StatefulWidget {
  final List<Stats> allStats;

  AccuracyChangeChart(this.allStats);

  @override
  _AccuracyChangeChartState createState() => _AccuracyChangeChartState();
}

class _AccuracyChangeChartState extends State<AccuracyChangeChart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.40,
      child: GradientContainer(
        accentColor: kDarkGreen,
        child: Column(
          children: [
            Text(
              "Accuracy Over time",
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
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = 0; i < widget.allStats.length; i++)
              FlSpot(i.toDouble(), widget.allStats[i].accuracy.toDouble())

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

  double getLowestAccuracy() {
    double minAccuracy = double.maxFinite;

    for (int i = 0; i < widget.allStats.length; i++) {
      if (widget.allStats[i].accuracy < minAccuracy) {
        minAccuracy = widget.allStats[i].accuracy.toDouble();
      }
    }

    return minAccuracy;
  }

  double getHighestAccuracy() {
    double maxAccuracy = 0;

    for (int i = 0; i < widget.allStats.length; i++) {
      if (widget.allStats[i].accuracy > maxAccuracy) {
        maxAccuracy = widget.allStats[i].accuracy.toDouble();
      }
    }

    return maxAccuracy;
  }
}
