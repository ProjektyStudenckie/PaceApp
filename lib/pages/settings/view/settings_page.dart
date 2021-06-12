import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pace_app/app/app.dart';
import 'package:pace_app/app/models/theme_settings.dart';
import 'package:pace_app/components/color_picker.dart';
import 'package:pace_app/components/default_text_form_field.dart';
import 'package:pace_app/pages/settings/cubit/settings_cubit.dart';
import 'package:pace_app/repository/authentication_repository.dart';
import 'package:pace_app/utils/toast_utils.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:pace_app/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeSettings>(
        initialData: ThemeSettings(
          themeBrightness: Theme.of(context).brightness
        ),
        stream: context.read<AppBloc>().outTheme,
        builder: (context, snapshot) {
          return BlocProvider<SettingsCubit>(create: (context) {
            var themeSettings = ThemeSettings();

            if (snapshot.hasData) {
              themeSettings = snapshot.data!;
            }

            return SettingsCubit(nickname: "", themeSettings: themeSettings);
          }, child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Center(
                  child: SettingsList(
                backgroundColor: Theme.of(context).backgroundColor,
                sections: [
                  SettingsSection(
                    titlePadding: EdgeInsets.only(left: 14, top: 20),
                    title: "Theme",
                    tiles: [
                      SettingsTile.switchTile(
                        leading: Icon(Icons.mode_night),
                        title: "Dark mode",
                        switchValue: state.darkTheme,
                        onToggle: (bool value) {
                          context
                              .read<SettingsCubit>()
                              .changeThemeBrightness(value);

                          context.read<AppBloc>().saveThemeBrightness(value);

                          context.read<AppBloc>().inTheme.call(ThemeSettings(
                              themeBrightness:
                                  value ? Brightness.dark : Brightness.light,
                              indicatorColor: snapshot.data?.indicatorColor ??
                                  Colors.yellow));
                        },
                      )
                    ],
                  ),
                  SettingsSection(
                    title: "Game",
                    tiles: [
                      SettingsTile(
                        title: "Indicator color",
                        leading: Icon(Icons.color_lens),
                        onPressed: (context) {
                          showDialog(
                              context: context,
                              builder: (context1) {
                                return AlertDialog(
                                    content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                      ColorPicker(
                                        onColorTap: (Color color) {
                                          context
                                              .read<SettingsCubit>()
                                              .changeIndicatorColor(color);

                                          context
                                              .read<AppBloc>()
                                              .saveIndicatorColor(color);

                                          context.read<AppBloc>().inTheme.call(
                                              ThemeSettings(
                                                  themeBrightness: snapshot.data
                                                          ?.themeBrightness ??
                                                      Brightness.dark,
                                                  indicatorColor: color));

                                          Navigator.pop(context1);
                                        },
                                      ),
                                    ]));
                              });
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: "User",
                    tiles: [
                      SettingsTile(
                        title: "Nickname",
                        subtitle: "John_Doe",
                        leading: Icon(Icons.color_lens),
                        onPressed: (context1) {
                          displayTextInputDialog(
                              context: context1,
                              title: "Enter new nickname",
                              onChanged: (newValue) {
                                context
                                    .read<SettingsCubit>()
                                    .changeNickname(newValue);
                              },
                              onConfirmed: () {
                                // TODO: Change nickname in db
                              });
                        },
                      ),
                      getSettingsTileButton(
                          title: "Reset password",
                          leadingIconData: Icons.password,
                          onPressed: (context) {
                            RepositoryProvider.of<AuthenticationRepository>(
                                    context)
                                .sendPasswordResetEmail();

                            showSuccessToast(context, "Email with reset link has been sent");
                          }),
                      getSettingsTileButton(
                          title: "Reset data",
                          leadingIconData: Icons.delete,
                          onPressed: (context) {
                            // TODO: Reset user data
                          },
                          color: Colors.redAccent),
                    ],
                  ),
                  SettingsSection(
                    tiles: [
                      getSettingsTileButton(
                          title: "Log out",
                          leadingIconData: Icons.logout,
                          onPressed: (context) {
                            BlocProvider.of<AppBloc>(context)
                                .add(AppLogoutRequested());
                          }),
                    ],
                  )
                ],
              ));
            },
          ));
        });
  }
}

SettingsTile getSettingsTileButton(
    {required String title,
    IconData? leadingIconData,
    required Function(BuildContext) onPressed,
    Color color = Colors.blueAccent}) {
  return SettingsTile(
    title: title,
    titleTextStyle: TextStyle(color: color),
    trailing: Icon(null),
    leading: Icon(
      leadingIconData,
      color: color,
    ),
    onPressed: (context) {
      onPressed(context);
    },
  );
}

Future<void> displayTextInputDialog(
    {required BuildContext context,
    String initialValue = "",
    String title = "",
    required Function(String) onChanged,
    required Function() onConfirmed}) async {
  return showDialog(
      context: context,
      builder: (context1) {
        return AlertDialog(
          title: Text(title),
          content: DefaultTextFormField(
            initialValue: initialValue,
            labelText: title,
            onChanged: (value) => onChanged.call(value),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.secondary)),
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context1);
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.secondary)),
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context1);
                onConfirmed.call();
              },
            ),
          ],
        );
      });
}
