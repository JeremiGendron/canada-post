import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

abstract class Destination {
  final String type;
  String kind;
  String location;

  Destination({@required this.type});
}

class InternationalDestination extends Destination {
  final String location;
  final String kind = "country-code";

  InternationalDestination({
    @required this.location,
  }) : super(type: "international");
}

class UnitedStatesDestination extends Destination {
  final String location;
  final String kind = "zip-code";
  UnitedStatesDestination({
    @required this.location,
  }) : super(type: "united-states");
}

class DomesticDestination extends Destination {
  final String location;
  final String kind = "postal-code";

  DomesticDestination({
    @required this.location,
  }) : super(type: "domestic");
}

buildDestination(XmlBuilder builder, Destination destination) {
  builder.element('destination', nest: () {
    builder.element(destination.type, nest: () {
      builder.element(destination.kind, nest: () {
        builder.text(destination.location);
      });
    });
  });
}