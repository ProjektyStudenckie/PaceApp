import 'dart:ui';
import 'package:async/async.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/app/app.dart';
import 'package:pace_app/app/models/theme_settings.dart';
import 'package:pace_app/constants.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/pages/game/cubit/game_cubit.dart';
import 'package:pace_app/repository/quotes_repository.dart';

class GameForm extends StatefulWidget {
  @override
  _GameFormState createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {
  final GameCubit _cubit = GameCubit(getIt.get());
  late final TextEditingController _controller;
  late List<TextSpan> _textSpans;
  late List<TextSpan> _textSpans2;
  late List<TextSpan> _textSpans3;

  @override
  void initState() {
    _controller = MyTextController(cubit: _cubit);
    _textSpans = [];
    _textSpans2 = [];
    _textSpans3 = [];
    _cubit.getQuote();
    super.initState();
  }

  @override
  void dispose() {
    _cubit.finishGame(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocBuilder<GameCubit, GameState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state.gameFinished) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Congratulations on finishing the game!',
                    style: kTextStyleCongrats.copyWith(
                        color: !state.isDarkMode ? Colors.black : Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 100),
                  Text(
                    'Accuracy: ${(_cubit.accuracy() * 100).toInt()}%',
                    style: kTextStyleStats.copyWith(
                        color: !state.isDarkMode ? Colors.black : Colors.white),
                  ),
                  Text(
                    'WPM: ${_cubit.wpm().round()}',
                    style: kTextStyleStats.copyWith(
                        color: !state.isDarkMode ? Colors.black : Colors.white),
                  ),
                  Text(
                    'Mistakes: ${_cubit.mistakes()}',
                    style: kTextStyleStats.copyWith(
                        color: !state.isDarkMode ? Colors.black : Colors.white),
                  ),
                ],
              );
            }

            if (!state.isLoading) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        StreamBuilder<ThemeSettings>(
                            stream: context.read<AppBloc>().outTheme,
                            builder: (context, snapshot) {
                              _cubit.isDarkMode(
                                  isDarkMode: snapshot.data?.themeBrightness ==
                                      Brightness.dark);
                              return TextField(
                                onChanged: (text) async {
                                  // check for mistakes
                                  int lastLetter = text.length - 1;
                                  if (text[lastLetter] !=
                                      state.gameText[lastLetter]) {
                                    _cubit.addMistake();
                                  }

                                  _cubit.setIndex(text.length);

                                  // end of the word
                                  if (text.length == state.gameText.length) {
                                    await Future.delayed(
                                        Duration(milliseconds: 100));

                                    // add to right column
                                    if (_textSpans2.length > 8) {
                                      _textSpans3.add(_cubit.getOldTextPart);
                                    } else if (_textSpans.length > 8) {
                                      _textSpans2.add(_cubit.getOldTextPart);
                                    } else {
                                      _textSpans.add(_cubit.getOldTextPart);
                                    }

                                    // clear textField
                                    _controller.clear();
                                    _cubit.setIndex(0);

                                    //finish the game
                                    if (_cubit.textPartsCount ==
                                        state.textPartIndex + 1) {
                                      _cubit.stopTheGame();
                                      _cubit.finishGame(true);
                                      return;
                                    }

                                    // move to another word
                                    _cubit.setTextPartIndex(
                                        state.textPartIndex + 1);
                                    _cubit.getText();
                                  }
                                },
                                textInputAction: TextInputAction.done,
                                maxLines: 99,
                                style: TextStyle(fontSize: 45.0),
                                controller: _controller,
                                cursorColor: snapshot.data?.indicatorColor ??
                                    Colors.yellow,
                                autofocus: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.only(top: 13.0),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: state.gameText
                                      .substring(0, state.currentIndex),
                                  style: TextStyle(
                                    color: Colors.grey.withOpacity(0.0),
                                    fontSize: 45.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: state.gameText
                                      .substring(state.currentIndex),
                                  style: TextStyle(
                                    color: Colors.grey.withOpacity(0.7),
                                    fontSize: 45.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: getChildren(_textSpans),
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: getChildren(_textSpans2),
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: getChildren(_textSpans3),
                      ),
                    ],
                  ),
                ],
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text(
                    'Loading content...',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class MyTextController extends TextEditingController {
  final GameCubit cubit;
  MyTextController({required this.cubit});

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    List<InlineSpan> children = [];
    List<InlineSpan> oldPart = [];
    String gameText = cubit.state.gameText;

    for (int i = 0; i < text.length; i++) {
      if (text[i] != gameText[i]) {
        children.add(TextSpan(
          style: kTextStyleRed,
          text: gameText[i],
        ));
        oldPart.add(TextSpan(
          style: kTextStyleOldPartRed,
          text: gameText[i],
        ));
        //cubit.addMistake();
      }

      if (text[i] == gameText[i]) {
        children.add(TextSpan(
          style: cubit.state.isDarkMode ? kTextStyleWhite : kTextStyleDark,
          text: gameText[i],
        ));
        oldPart.add(TextSpan(
          style: cubit.state.isDarkMode
              ? kTextStyleOldPartWhite
              : kTextStyleOldPartDark,
          text: gameText[i],
        ));
      }
    }

    cubit.setOldTextPart(TextSpan(style: style, children: oldPart));
    return TextSpan(style: style, children: children);
  }
}

List<RichText> getChildren(List<TextSpan> spans) {
  List<RichText> list = [];
  for (int i = 0; i < spans.length; i++) {
    list.add(RichText(
      text: spans[i],
    ));
  }
  return list;
}
