import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pace_app/components/rounded_button.dart';
import 'package:pace_app/utils/toast_utils.dart';
import '../../../constants.dart';
import '../registration.dart';

class RegistrationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    String passwordConfirm;

    return Scaffold(
      body: BlocConsumer<RegistrationCubit, RegistrationState>(
        listener: (context, state) {
          // if (state is CurrentUserError) {
          //   ToastUtils.showCustomToast(
          //       context, getMessageWithExceptionCode(state.message));
          // } else if (state is CurrentUserLoggedIn) {
          //   Navigator.pushNamed(context, MainScreen.id);
          // }
           
          if (state.status == FormzStatus.submissionFailure) {
            ToastUtils.showCustomToast(context, "Authentication Failed");
          }

          // TODO: Find if it should be done differently
          else if (state.status == FormzStatus.submissionSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall:
                state.status == FormzStatus.submissionInProgress ? true : false,
            child: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 15.0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          child: Hero(
                            tag: 'logo',
                            child: Container(
                              height: 200.0,
                              child: Image.asset('images/logo.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 48.0,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (email) => context
                              .read<RegistrationCubit>()
                              .emailChanged(email),
                          decoration: kTextFieldDecoration,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (password) => context
                              .read<RegistrationCubit>()
                              .passwordChanged(password),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your password',
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (confirmedPassword) => context
                              .read<RegistrationCubit>()
                              .confirmedPasswordChanged(confirmedPassword),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Re-Enter your password',
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        RoundedButton(
                          color: Colors.blueAccent,
                          text: 'Register',
                          onPressed: () async {
                            BlocProvider.of<RegistrationCubit>(context)
                                .registrationFormSubmitted();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
