import 'package:flutter/material.dart';
import 'game_settings_form.dart';

class GameSettingsPage extends StatelessWidget {
  const GameSettingsPage({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: GameSettingsPage());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const GameSettingsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GameSettingsForm(),
      ),
    );
  }
}
