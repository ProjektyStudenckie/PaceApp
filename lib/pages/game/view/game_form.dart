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

  @override
  void initState() {
    _controller = MyTextController(cubit: _cubit);
    _textSpans = [];
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
                    style: kTextStyleCongrats,
                  ),
                  SizedBox(height: 100),
                  Text(
                    'Accuracy: ${_cubit.accuracy()}',
                    style: kTextStyleStats,
                  ),
                  Text(
                    'WPM: ${_cubit.wpm()}',
                    style: kTextStyleStats,
                  ),
                  Text(
                    'Mistakes: ${_cubit.mistakes()}',
                    style: kTextStyleStats,
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
                              return TextField(
                                onChanged: (text) async {
                                  _cubit.enableCountingMistakes(true);
                                  _cubit.enableChangingWord(true);
                                  _cubit.addLetter();
                                  if (text.length == state.gameText.length) {
                                    await Future.delayed(
                                        Duration(milliseconds: 100));
                                    _textSpans.add(_cubit.getOldTextPart);
                                    _controller.clear();

                                    //finish the game
                                    if (_cubit.textPartsCount ==
                                        state.textPartIndex + 1) {
                                      _cubit.stopTheGame();
                                      _cubit.finishGame(true);
                                      return;
                                    }

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
                  Column(
                    children: getChildren(_textSpans),
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
    int gameTextLength = cubit.state.gameTextLength;

    if (text.length == gameTextLength && cubit.state.playGame) {
      print('neeext');
      cubit.setTextPartIndex(cubit.state.textPartIndex + 1);
      cubit.enableChangingWord(false);
    }

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
        cubit.addMistake();
      }

      if (text[i] == gameText[i]) {
        children.add(TextSpan(
          style: kTextStyleWhite,
          text: gameText[i],
        ));
        oldPart.add(TextSpan(
          style: kTextStyleOldPartWhite,
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
