# field_validators

<img src="https://forthebadge.com/images/badges/built-with-love.svg" height="28px" />

Easy to use validators for Flutter forms.


## Getting started

First, add the `field_validators` package to your pubspec.yaml.
```yaml
dependencies:
  field_validators: <Package version>
```
or
```yaml
dependencies:
  field_validators:
    git: 
      url: https://github.com/AxonDesigns/field_validators.git
```
then, execute `flutter pub get`.

Now, import the package in your Dart code, use:
```dart
import 'package:field_validators/field_validators.dart';
```

## Usage

Simple use of the `FieldValidators` class to validate a `textFormField`.

```dart
TextFormField(
  ...
  validator: FieldValidators.required(error: "Field is required"),
),
```

You can also use the `compose` function to combine multiple validators:

```dart
FormField<String>(
  ...
  validator: FieldValidators.compose([
    FieldValidators.required(error: "Field is required"),
    FieldValidators.number(error: "Field must be a number"),
    FieldValidators.min(10, error: "Field must be at least 10 digits long"),
  ]),
),
```

You can also use the `custom` function to create your own validator and compose it with other validators:

```dart
FormField<int>(
  ...
  validator: FieldValidators.compose([
    FieldValidators.required(error: "Field is required"),
    FieldValidators.custom((value) {
      if ( <an even more complex validation condition> ) {
        return "Field is invalid";
      }
      return null;
    }),
  ]),
),
```

If that's not enough, you can create your own class with some validators like so:

```dart
class MyValidators {
  static String? Function(T? value) myValidator<T>(String error) {
    return (value) {
      if (<another more complex validation condition>) {
        return error;
      }
      return null;
    };
  }
}
```

And then use it like this:

```dart
FormField<int>(
  ...
  validator: FieldValidators.compose([
    FieldValidators.required(error: "Field is required"),
    MyValidators.myValidator("Field is invalid"),
  ]),
),
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
