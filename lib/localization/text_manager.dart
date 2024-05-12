import 'package:syncrosong/localization/localized_text.dart';

class TextManager {
  static final TextManager _instance = TextManager._();

  TextManager._();

  String provide(LocalizedText textEnum) => textEnum.englishText;

  String _provideWithValues(LocalizedText textEnum, List<String> values) {
    List<String> splitString = provide(textEnum).split(LocalizedText.valuePlaceholder);
    StringBuffer resultString = StringBuffer();
    for (int index = 0; index < splitString.length - 1; index++) {
      resultString.write(splitString[index]);
      resultString.write(values[index]);
    }
    resultString.write(splitString.last);
    return resultString.toString();
  }
}

mixin TextProvider {
  String getText(LocalizedText textEnum, {List<String> values = const [], String? value}) {
    if (value != null) {
      return TextManager._instance._provideWithValues(textEnum, [value]);
    } else if (values.isNotEmpty) {
      return TextManager._instance._provideWithValues(textEnum, values);
    } else {
      return TextManager._instance.provide(textEnum);
    }
  }
}
