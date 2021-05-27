import 'package:flutter/widgets.dart';
import 'package:pace_app/app/bloc/app_bloc.dart';
import 'package:pace_app/pages/navbar_container/navbar_container.dart';
import 'package:pace_app/pages/welcome/welcome_page.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [NavbarContainer.page()];
    case AppStatus.unauthenticated:
    default:
      return [WelcomePage.page()];
  }
}
