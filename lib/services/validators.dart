class FormValidators {
  String? emailValidator(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    final emailRegEx = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegEx.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  String? phoneNumberValidator(String value) {
    if (value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegEx = RegExp(r'^[0-9]{10}$');
    if (!phoneRegEx.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? fullNameValidator(String value) {
    if (value.isEmpty) {
      return 'Full name is required';
    }
    return null;
  }

  String? passwordConfirmValidator(String value, String password) {
    if (value.isEmpty) {
      return 'Password confirm is required';
    }
    if (value != password) {
      return 'Password confirm must be equal to password';
    }
    return null;
  }
}
