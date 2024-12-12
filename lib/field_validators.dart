library field_validators;

typedef ValidationFunction<T> = String? Function(T? value);

class FieldValidators {
  static ValidationFunction<T> compose<T>(List<ValidationFunction<T>> validators) {
    return (value) {
      for (var validator in validators) {
        if (validator(value) != null) {
          return validator(value);
        }
      }
      return null;
    };
  }

  static ValidationFunction<T> email<T>({String error = "Invalid email"}) {
    return (value) {
      if (value == null) return null;
      if (!RegExp(r"^(?=[a-zA-Z0-9@._%+-]{1,254}$)([a-zA-Z0-9._%+-]+)@([a-zA-Z0-9-]+\.[a-zA-Z]{2,})$").hasMatch(value.toString())) return error;
      return null;
    };
  }

  static ValidationFunction<T> required<T>({String error = "Required"}) {
    return (value) {
      if (value == null) return error;
      if (value.toString().isEmpty) return error;
      return null;
    };
  }

  static ValidationFunction<T> minLength<T>(int minLength, {String error = "Too short"}) {
    return (value) {
      if (value == null) return error;
      if (value.toString().length < minLength) return error;
      return null;
    };
  }

  static ValidationFunction<T> maxLength<T>(int maxLength, {String error = "Too long"}) {
    return (value) {
      if (value == null) return error;
      if (value.toString().length > maxLength) return error;
      return null;
    };
  }

  static ValidationFunction<T> exactLength<T>(int maxLength, {String error = "Invalid length"}) {
    return (value) {
      if (value == null) return error;
      if (value.toString().length != maxLength) return error;
      return null;
    };
  }

  static ValidationFunction<T> lengthBetween<T>(int minLength, int maxLength, {String errorShort = "Too short", String errorLong = "Too long"}) {
    return (value) {
      if (value == null) return errorShort;
      if (value.toString().length < minLength) return errorShort;
      if (value.toString().length > maxLength) return errorLong;
      return null;
    };
  }

  static ValidationFunction<T> number<T>({String error = "Invalid number"}) {
    return (value) {
      if (value == null) return error;
      if (double.tryParse(value.toString()) == null) return error;
      return null;
    };
  }

  static ValidationFunction<T> equals<T>(String other, {String error = "Invalid"}) {
    return (value) {
      if (value == null) return error;
      if (value.toString() != other) return error;
      return null;
    };
  }

  static ValidationFunction<T> custom<T>({required ValidationFunction<T> validator, String error = "Invalid"}) {
    return (value) {
      if (value == null) return error;
      if (validator(value) != null) return error;
      return null;
    };
  }
}
