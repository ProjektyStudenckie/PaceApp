import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/components/gradient_container.dart';
import 'package:pace_app/components/wpm_change_chart.dart';
import 'package:pace_app/constants.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/pages/stats/cubit/stats_cubit.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatsCubit(
          statsRepository: getIt()),
      child: BlocBuilder<StatsCubit, StatsState>(
        builder: (context, state) {
          BlocProvider.of<StatsCubit>(context).loadStats();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Header(title: state.email.split("@").first),
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
                                if (state.loaded) ...[
                                  DataField(
                                      label: "WPM",
                                      value:
                                          state.averageWPM.toInt().toString()),
                                  Divider(color: Colors.white24, thickness: 2),
                                  DataField(label: "Rank", value: "44"),
                                ] else
                                  Center(child: CircularProgressIndicator())
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
                                if (state.loaded) ...[
                                  DataField(
                                      label: "ACCURACY",
                                      value: (state.averageAccuracy * 100)
                                          .toInt()
                                          .toString()),
                                  Divider(
                                    color: Colors.white24,
                                    thickness: 2,
                                  ),
                                  DataField(label: "Rank", value: "1"),
                                ] else
                                  Center(child: CircularProgressIndicator())
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
                  WPMChangeChart(state.allStats),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    print("Title: $title");
    print("title: ${title.isEmpty}");

    return GradientContainer(
        child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Icon(
            Icons.person,
            size: 40,
          ),
        ),
        SizedBox(width: 12),
        if (title.isNotEmpty)
          Expanded(
            child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  softWrap: true,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 34,
                      color: Colors.white),
                )),
          )
        else
          CircularProgressIndicator()
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
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          )
        ],
      ),
    );
  }
}
