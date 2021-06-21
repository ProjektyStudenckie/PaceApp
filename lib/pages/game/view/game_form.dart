import 'dart:ui';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/app/app.dart';
import 'package:pace_app/app/models/theme_settings.dart';
import 'package:pace_app/constants.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/pages/game/cubit/game_cubit.dart';

class GameForm extends StatefulWidget {
  @override
  _GameFormState createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {
  final GameCubit _cubit = GameCubit(getIt.get());
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocBuilder<GameCubit, GameState>(
          bloc: _cubit,
          builder: (context, state) {
            return Center(
              child: Stack(
                children: [
                  StreamBuilder<ThemeSettings>(
                      stream: context.read<AppBloc>().outTheme,
                      builder: (context, snapshot) {
                        return TextField(
                          onChanged: (text) {
                            _cubit.enableCountingMistakes(true);
                            _cubit.addLetter();
                            if (text.length == state.gameText.length) {
                              _controller.clear();
                              _cubit.setTextPartIndex(state.textPartIndex + 1);
                              _cubit.getText();
                            }
                          },
                          textInputAction: TextInputAction.done,
                          maxLines: 99,
                          style: TextStyle(fontSize: 27.0),
                          controller: _controller,
                          cursorColor:
                              snapshot.data?.indicatorColor ?? Colors.yellow,
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
    String gameText = cubit.state.gameText;
    cubit.setIndex(text.length);

    if (text.length == gameText.length) {
      cubit.setTextPartIndex(cubit.state.textPartIndex + 1);
    }

    for (int i = 0; i < text.length; i++) {
      if (text[i] != gameText[i]) {
        children.add(TextSpan(
          style: kTextStyleRed,
          text: gameText[i],
        ));
        cubit.addMistake();
      }

      if (text[i] == gameText[i]) {
        children.add(TextSpan(
          style: kTextStyleWhite,
          text: gameText[i],
        ));
        //cubit.addLetter();
      }
    }

    return TextSpan(style: style, children: children);
  }
}
