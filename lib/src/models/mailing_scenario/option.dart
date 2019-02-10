import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

class Option {
  final String optionCode;
  String optionAmount;

  Option({@required this.optionCode, double optionAmount}) {
    if (optionAmount == null && this.optionCode == "COV") {
      throw ArgumentError('optionCode "COV" requires an optionAmount');
    }

    if (optionAmount != null && optionAmount > 99999.99) {
      throw ArgumentError('optionAmount must not exceed 99999.99');
    }

    if (optionAmount != null) {
      this.optionAmount = optionAmount.toStringAsFixed(2);
    }
  }
}

void buildOptions(XmlBuilder builder, List<Option> options) {
  builder.element('options', nest: () {
    options.forEach((option) {
      builder.element('option', nest: () {
        builder.element('option-code', nest: () {
          builder.text(option.optionCode);
        });
        if (option.optionAmount != null)
          builder.element('option-amount', nest: () {
            builder.text(option.optionAmount);
          });
      });
    });
  });
}