class StringConstants {
  static const welcomeText = "Food you wish,right at your feet";
  static const loginText = "Log In";
  static const enterNumber = "  Enter Mobile Number";
  static const mobileHintText = "+91 9999988888";
  static const termsText1 = "By signing up I agree to the ";
  static const termsText2 = "Terms of use ";
  static const termsText3 = "and ";
  static const termsText4 = "Privacy Policy";
  static const sendotpText = "Send OTP";
  static const noAccount = "Don't have an account?";
  static const register = "Register";
  static const otpVerifyText = "Enter OTP to verify";
  static const otpSentText = "We have sent a  verification code to";
  static const verifyOtpText = "Verify OTP";
  static const otpVerificationText = "OTP Verification";
  static const otpNotReceivedText = "Didn't get the OTP?";
  static const resendOtp = "Resend SMS";
  static const goBackToLogin = "Go back to login methods";
  static const personalInfo = "Personal Information";
  static const detailText =
      "Please fill up the details below so we can know you";
  static const name = "Name";
  static const dob = "Date of Birth";
  static const whatsapp = "Whatsapp Number";
  static const mobile = "Mobile Number";
  static const address = "Address";
  static const nameHintText = "Enter Full Name";
  static const dobHintText = "dd/mm/yyyy";
  static const addressHintText = "Enter your complete address";
  static const submitText = "Submit";
  static const orderText = "Orders";

  static String getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Account already exits.Please Login.";

      case "weak-password":
        return "Weak Password!";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";

      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No account exits with the given credentials.Please register.";

      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";

      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";

      case "ERROR_OPERATION_NOT_ALLOWED":
        return "Server error, please try again later.";

      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";

      default:
        return "Login failed. Please try again.";
    }
  }
}
