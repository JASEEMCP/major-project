import 'package:flutter/material.dart';
import 'package:app/resource/utils/extensions.dart';

extension ControllerListX on List<TextEditingController> {
  // Checking is all empty
  bool isAllEmpty() {
    return every((controller) => controller.text.trim().isEmpty);
  }

  bool isAnyOneEmpty() {
    return any((controller) => controller.text.trim().isEmpty);
  }

  bool allSame() {
    return every((controller) => controller.text.trim() == this[0].text.trim());
  }

  bool isItemEmpty(int index) {
    if (index >= 0 && index < length) {
      return this[index].text.trim().isEmpty;
    }
    return false;
  }

  bool isValidEmailAt(int index) {
    if (index >= 0 && index < length) {
      final nameRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}");
      return !nameRegExp.hasMatch(this[index].text.trim());
    }
    return false;
  }

  bool isInvalidPhoneAt(int index) {
    if (index >= 0 && index < length) {
      final phoneRegExp = RegExp(r"^[0-9]{10}$");

      return !phoneRegExp.hasMatch(this[index].text.trim());
    }
    return false;
  }

  bool isValidPasswordAt(int index) {
    if (index >= 0 && index < length) {
      final passwordRegExp = RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
      return !passwordRegExp.hasMatch(this[index].text.trim());
    }
    return false;
  }

  String joinTextController() {
    return map((e) => e.text).join('').trim();
  }
}

// Checking url
bool isValidUrl(String? url) {
  if (url == null) return false;
  final RegExp urlRegExp = RegExp(
      r"^(https?):\/\/(?:www\.)?((?!-)[A-Za-z0-9-]{1,63}(?<!-)\.)+([A-Za-z]{2,63}|[A-Za-z]{1,5}\.[A-Za-z]{2,63})(?::\d{1,5})?(?:\/[^\s]*)?$");

  // Check if the TLD is not a single character without a proper domain name
  if (urlRegExp.hasMatch(url)) {
    final uri = Uri.parse(url);
    final tld = uri.host.split('.').last;
    if (tld.length == 1 && uri.host.split('.').length == 1) {
      return false;
    }
    return true;
  } else {
    return false;
  }
}

///Check date is not null
String? isDateNull(String? date) {
  if (date == null || date.isEmpty) {
    return 'Date attribute is Required';
  }
  return null;
}

GlobalKey<FormState> generateFormKey() {
  return GlobalKey<FormState>();
}

TextEditingController generateTextController() {
  return TextEditingController();
}

//form validator
bool isEmptyString(String? value) {
  if (value != null && value.trim().isEmpty) {
    return true;
  }
  return false;
}

///validating number
bool isInt(String? number) {
  if (number == null) return false;
  final numberRegExp = RegExp(r'^[0-9]+$');
  if (numberRegExp.hasMatch(number.trim())) {
    return true;
  } else {
    return false;
  }
}

///validating floating number
bool isDouble(String? number) {
  if (number == null) return false;
  final numberRegExp = RegExp(r'^[0-9]*(?:\.[0-9]+)?$');
  if (numberRegExp.hasMatch(number.trim())) {
    return true;
  } else {
    return false;
  }
}

// Handle null strings
String? handleNullString(TextEditingController controller) {
  if (controller.text.trim().isEmpty) {
    return null;
  }
  return controller.text.trim();
}

String? handleEmptyString(TextEditingController controller,
    {bool toUpper = false, bool isUrl = false}) {
  if (controller.text.trim().isEmpty) {
    return null;
  } else {
    if (isUrl) {
      return controller.text.trim().toLowerCase();
    }
    if (toUpper) {
      return controller.text.trim().toUpperCase();
    }
    return controller.text.trim().toTitleCase();
  }
}

String? handleNullInteger(int? num) {
  if (num == null) {
    return null;
  } else {
    return num.toString();
  }
}

String? getSalaryToLpa(int? salary) {
  if (salary == null) return 'N/A';
  return ((salary) * 0.00012).toStringAsFixed(2);
}

String handleIntToString(int? num) {
  if (num == null) {
    return '';
  } else {
    return num.toString();
  }
}

String handleDoubleToString(double? num) {
  if (num == null) {
    return '';
  } else {
    return num.toString();
  }
}

int? stringToInt(String? num) {
  if (num == null || num.trim() == '') {
    return null;
  } else {
    return int.tryParse(num);
  }
}

double? stringToDouble(String? num) {
  if (num == null || num.trim() == '') {
    return null;
  } else {
    return double.tryParse(num);
  }
}
