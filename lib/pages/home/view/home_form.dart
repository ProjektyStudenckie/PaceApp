import 'dart:ui';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/constants.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/pages/home/cubit/home_cubit.dart';

class HomeForm extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  final HomeCubit _cubit = HomeCubit(getIt.get());
  late final TextEditingController _controller;

  @override
  void initState() {
    _cubit.setup();
    _controller = MyTextController(cubit: _cubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state.playGame) {
            return Center(
              child: Stack(
                children: [
                  TextField(
                    textInputAction: TextInputAction.done,
                    maxLines: 99,
                    style: TextStyle(fontSize: 27.0),
                    controller: _controller,
                    cursorColor: Colors.yellow,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                state.gameText.substring(0, state.currentIndex),
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.0),
                              fontSize: 27.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: state.gameText.substring(state.currentIndex),
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.7),
                              fontSize: 27.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          return Center(
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7);
                    }

                    if (states.contains(MaterialState.focused)) {
                      return Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7);
                    }

                    if (states.contains(MaterialState.pressed)) {
                      return Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.85);
                    }

                    return Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.2);
                  },
                ),
                minimumSize: MaterialStateProperty.resolveWith<Size>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Size(140.0, 50.0);
                  }

                  if (states.contains(MaterialState.focused)) {
                    return Size(140.0, 50.0);
                  }

                  if (states.contains(MaterialState.pressed)) {
                    return Size(160.0, 60.0);
                  }

                  return Size(130.0, 42.0);
                }),
              ),
              onPressed: () {
                _cubit.startOrFinishTheGame(startTheGame: true);
              },
              child: Text(
                'Play',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyTextController extends TextEditingController {
  final HomeCubit cubit;
  MyTextController({required this.cubit});

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    List<InlineSpan> children = [];
    String gameText = cubit.state.gameText;

    cubit.setCurrentIndex(text.length);

    for (int i = 0; i < text.length; i++) {
      if (gameText[i] == ' ' && text[i] != ' ') {
        children.add(TextSpan(
          style: kTextStyleRed,
          text: text[i],
        ));
        gameText = StringUtils.addCharAtPosition(gameText, text[i], i);
        continue;
      }

      if (text[i] != gameText[i]) {
        children.add(TextSpan(
          style: kTextStyleRed,
          text: gameText[i],
        ));
      }

      if (text[i] == gameText[i]) {
        children.add(TextSpan(
          style: kTextStyleWhite,
          text: gameText[i],
        ));
      }
    }

    return TextSpan(style: style, children: children);
  }
}
