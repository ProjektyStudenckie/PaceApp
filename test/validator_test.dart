import 'package:flutter_test/flutter_test.dart';
import 'package:pace_app/forms/models/confirmed_password.dart';
import 'package:pace_app/forms/models/email.dart';
import 'package:pace_app/forms/models/password.dart';

void main() async {
  group("validator tests", () {
    test("email validator", () {
      expect(Email.dirty("test@ok.pl").valid, true);
      expect(Email.dirty("test").valid, false);
      expect(Email.dirty("@ok.pl").valid, false);
      expect(Email.dirty("test.ok.pl").valid, false);
    });

    test("password validator", () {
      expect(Password.dirty("123456").valid, true);
      expect(Password.dirty("12345").valid, false);
    });

    test("confirmed password validator", () {
      var pass = ConfirmedPassword.dirty(password: "password123");

      expect(pass.validator("password123"), null);
      expect(pass.validator("password1"),
          ConfirmedPasswordValidationError.invalid);
    });
  });
}