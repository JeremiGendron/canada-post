import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

import './dimensions.dart';
export './dimensions.dart';

class ParcelCharacteristics {
  final Dimensions dimensions;
  final bool mailingTube;
  final bool oversized; // set automatically
  final bool unpackaged;
  String weight;

  ParcelCharacteristics(
      {@required double weight,
      @required this.dimensions,
      this.mailingTube = false,
      this.unpackaged = false})
      : oversized = dimensions.oversized {
    if (weight > 99.999) {
      throw ArgumentError("Weight must not exceed 99.999 kg");
    }
    if (this.mailingTube && this.unpackaged) {
      throw ArgumentError(
          "Parcel can't be both unpackaged and in a mailingTube");
    }

    this.weight = weight.toStringAsFixed(3);
  }
  //

}

void buildParcelCharacteristics(XmlBuilder builder, ParcelCharacteristics parcelCharacteristics) {
  builder.element('parcel-characteristics', nest: () {
    buildWeight(builder, parcelCharacteristics.weight);
    buildDimensions(builder, parcelCharacteristics.dimensions);
    buildOptionals(builder, parcelCharacteristics);
  });
}

void buildWeight(XmlBuilder builder, String weight) {
  builder.element('weight', nest: () {
    builder.text(weight);
  });
}

void buildOptionals(XmlBuilder builder, ParcelCharacteristics parcelCharacteristics) {
  if (parcelCharacteristics.unpackaged) {
    builder.element('unpackaged', nest: () {
      builder.text(parcelCharacteristics.unpackaged);
    });
  } else if (parcelCharacteristics.mailingTube) {
    builder.element('mailingTube', nest: () {
      builder.text(parcelCharacteristics.mailingTube);
    });
  }

  if (parcelCharacteristics.oversized) {
    builder.element('oversied', nest: () {
      builder.text(parcelCharacteristics.oversized);
    });
  }
}