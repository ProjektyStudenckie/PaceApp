import 'package:flutter/material.dart';
import 'package:pace_app/components/gradient_container.dart';
import 'package:pace_app/components/wpm_change_chart.dart';
import 'package:pace_app/constants.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Header(title: "Jakub Sosna"),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GradientContainer(
                      center: Alignment.bottomLeft,
                      accentColor: kDarkRed,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DataField(label: "WPM", value: "129"),
                          Divider(color: Colors.white24, thickness: 2),
                          DataField(label: "Rank", value: "44"),
                        ],
                      )),
                  flex: 2,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: GradientContainer(
                      center: Alignment.topCenter,
                      accentColor: kDarkGreen,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DataField(label: "ACCURACY", value: "100"),
                          Divider(
                            color: Colors.white24,
                            thickness: 2,
                          ),
                          DataField(label: "Rank", value: "1"),
                        ],
                      )),
                  flex: 3,
                )
              ],
            ),
            Divider(
              height: 36,
              thickness: 2,
            ),
            WPMChangeChart(),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
        child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(
            Icons.person,
            size: 40,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                softWrap: true,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 34),
              )),
        )
      ],
    ));
  }
}

class DataField extends StatelessWidget {
  const DataField({Key? key, required this.label, required this.value})
      : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
