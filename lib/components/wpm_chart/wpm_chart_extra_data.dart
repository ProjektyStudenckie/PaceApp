import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pace_app/components/wpm_chart/wpm_change_chart.dart';
import 'package:pace_app/constants.dart';
import 'package:pace_app/repository/models/stats.dart';

LineChartData extraData(List<Stats> allStats) {
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
      maxX: allStats.length.toDouble() - 1,
      minY: 0,
      maxY: getUpperBoundary(allStats).toDouble() + 10 < 100
          ? 100
          : getUpperBoundary(allStats).toDouble() + 10,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (int i = 0; i < allStats.length; i++)
              FlSpot(i.toDouble(), allStats[i].grossWpm.toDouble())
          ],
          isCurved: true,
          colors: gradientColorsPurple,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColorsPurple.map((color) => color.withOpacity(0.1)).toList(),
          ),
        ),
        LineChartBarData(
          spots: [
            for (int i = 0; i < allStats.length; i++)
              FlSpot(i.toDouble(), allStats[i].wpm)
          ],
          isCurved: true,
          colors: gradientColorsRed,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColorsRed.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;

                if (flSpot.barIndex == 0) {
                  return LineTooltipItem(
                    'Gross WPM\n',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: flSpot.y.toString(),
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                        ),
                      ),
                    ],
                  );
                } else if (flSpot.barIndex == 1) {
                  return LineTooltipItem(
                    'Net WPM\n',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: flSpot.y.toString(),
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                        ),
                      ),
                    ],
                  );
                }
              }).toList();
            }),
      ));
}
