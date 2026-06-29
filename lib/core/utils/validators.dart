class Validators {
  Validators._();

  static final RegExp _emailPattern = RegExp(
    r'[a-zA-Z0-9+._%-+]{1,256}\@[a-zA-Z0-9][a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+',
  );

  static String? required(String? value, {String message = 'This field is required'}) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  static String? email(String? value, {String message = 'Enter a valid email'}) {
    if (value == null || value.isEmpty) return null;
    return _emailPattern.hasMatch(value) ? null : message;
  }

  static String? password(String? value, {String message = 'Password must be at least 6 characters'}) {
    if (value == null || value.length < 6) return message;
    return null;
  }

  static bool isNumeric(String value) {
    if (value.isEmpty) return false;
    return num.tryParse(value) != null;
  }
}
