import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pace_app/components/rounded_button.dart';
import 'package:pace_app/utils/toast_utils.dart';
import '../../../constants.dart';
import '../registration.dart';
import 'package:pace_app/injection/injection.dart';

class RegistrationForm extends StatelessWidget {
  final RegistrationCubit _cubit = RegistrationCubit(getIt.get());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegistrationCubit, RegistrationState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state.status == FormzStatus.submissionFailure) {
            showErrorToast(context, "Registration Failed!");
          }
          
          else if (state.status == FormzStatus.submissionSuccess) {
            showSuccessToast(context, "Succesfully Registered!");
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SafeArea(
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
                        onChanged: (email) => _cubit.emailChanged(email),
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Enter your email",
                            errorText:
                                state.email.invalid ? 'invalid email' : null),
                      ),
                      SizedBox(
                        height: state.email.invalid ? 8.0 : 30.0,
                      ),
                      TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        onChanged: (password) =>
                            _cubit.passwordChanged(password),
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your password',
                            errorText: state.password.invalid
                                ? 'invalid password'
                                : null),
                      ),
                      SizedBox(
                        height: state.password.invalid ? 8.0 : 30.0,
                      ),
                      TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        onChanged: (confirmedPassword) =>
                            _cubit.confirmedPasswordChanged(confirmedPassword),
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Re-Enter your password',
                            errorText: state.confirmedPassword.invalid
                                ? 'passwords do not match'
                                : null),
                      ),
                      SizedBox(
                        height: state.confirmedPassword.invalid ? 24.0 : 46.0,
                      ),
                      RoundedButton(
                        color: Colors.blueAccent,
                        content:
                            state.status != FormzStatus.submissionInProgress
                                ? Text("REGISTER")
                                : Container(
                                    height: 50.0,
                                    child: Image.asset('images/logo.png'),
                                  ),
                        onPressed: () async {
                          if (state.status.isValidated) {
                            _cubit.registrationFormSubmitted();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
