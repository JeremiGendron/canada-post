import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

class Dimensions {
  String height;
  String width;
  String length;
  bool oversized;

  Dimensions({@required List<double> dimensions // in centimeters
      })
      : oversized = false {
    if (dimensions.length != 3) {
      throw ArgumentError(
          "Must provide length, width and height for dimensions. (3 doubles)");
    }

    dimensions.sort();

    dimensions.asMap().forEach((i, dimension) {
      if (dimension > 999.9) {
        this.oversized = true;
      }

      switch (i) {
        case 0:
          this.height = dimension.toStringAsFixed(1);
          break;
        case 1:
          this.width = dimension.toStringAsFixed(1);
          break;
        case 2:
          this.length = dimension.toStringAsFixed(1);
          break;
        default:
      }
    });
  }
  //

  static inchesToCentimeters() {}
  static singleInchesToCentimeters() {}
}

void buildDimensions(XmlBuilder builder, Dimensions dimensions) {
  builder.element('dimensions', nest: () {
    builder.element('length', nest: () {
      builder.text(dimensions.length);
    });
    builder.element('width', nest: () {
      builder.text(dimensions.width);
    });
    builder.element('height', nest: () {
      builder.text(dimensions.height);
    });
  });
}