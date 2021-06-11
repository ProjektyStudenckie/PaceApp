import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pace_app/pages/navbar_container/navbar_container.dart';

void main() {
  group('test bottom navigation bar', () {
    testWidgets(
      "navigate to play/home page",
      (WidgetTester tester) async {
        var playButton = find.byIcon(Icons.videogame_asset_outlined);

        await tester.pumpWidget(MaterialApp(home: NavBarContainer()));
        await tester.tap(playButton);
        await tester.pump();

        expect(find.text("Home"), findsWidgets);
      },
    );

    testWidgets(
      "navigate to stats page",
      (WidgetTester tester) async {
        var statsButton = find.byIcon(Icons.show_chart);

        await tester.pumpWidget(MaterialApp(home: NavBarContainer()));

        expect(find.text("Stats"), findsOneWidget);

        await tester.tap(statsButton);
        await tester.pump();

        expect(find.text("Stats"), findsWidgets);
      },
    );

    testWidgets(
      "navigate to settings page",
      (WidgetTester tester) async {
        var settingsButton = find.byIcon(Icons.settings);

        await tester.pumpWidget(MaterialApp(home: NavBarContainer()));

        expect(find.text("Settings"), findsOneWidget);

        await tester.tap(settingsButton);
        await tester.pump();

        expect(find.text("Settings"), findsWidgets);
      },
    );
  });
}