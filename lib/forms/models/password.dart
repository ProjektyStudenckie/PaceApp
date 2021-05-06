import 'package:formz/formz.dart';

enum PasswordError { invalid }

class Password extends FormzInput<String, PasswordError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordError? validator(String value) {
    print("Pass validator called");
    // return _passwordRegExp.hasMatch(value ?? '')
    //     ? null
    //     : PasswordValidationError.invalid;
    //
    //return value.length >= 6 ? null : PasswordValidationError.invalid;
    return null;
  }
}
