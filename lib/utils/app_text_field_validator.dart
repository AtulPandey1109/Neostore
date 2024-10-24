class AppTextFieldValidator {
  static String? validateEmail(String email) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return email.length < 3 || !regex.hasMatch(email)
        ? 'Please enter a valid email'
        : null;
  }

  static String? validatePhoneNumber(String phoneNo) {
    RegExp phoneRegEx = RegExp(r'^[0-9]');
    return !phoneRegEx.hasMatch(phoneNo) ||
            phoneNo.isEmpty ||
            !(phoneNo.length == 10)
        ? 'Please enter valid phone number'
        : null;
  }

  static String? validateAge(String age) {
    int ageValue = 0;
    try {
      ageValue = int.parse(age);
    } catch (e) {
      return 'Please enter a valid age';
    }
    return ageValue < 10 || ageValue > 150 ? 'Please enter a valid age' : null;
  }

  static String? isValidPassword(String password) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password)
        ? null
        : 'Password must contain at least one uppercase letter, one lowercase letter, one digit, one special character and should have minimum length of 8 characters';
  }
}
