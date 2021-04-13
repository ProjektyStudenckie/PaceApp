String getMessageWithExceptionCode(String code) {
  switch (code) {
    case "user-not-found":
      return "User not found!";
    case "wrong-password":
      return "Wrong password!";
    case "email-already-in-use":
      return "Email already in use!";
    case "user-disabled":
      return "Account Disabled!";
    case "invalid-email":
      return "Email is invalid!";

    default:
      return code;
  }
}
