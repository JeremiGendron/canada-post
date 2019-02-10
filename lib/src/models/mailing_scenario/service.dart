import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

class Service {
  String serviceCode;

  Service({
    @required this.serviceCode
  });
}

void buildServices(XmlBuilder builder, List<Service> services) {
  if (services == null) return;
  if (services.length > 20) {
    throw ArgumentError('limit of 20 services per request');
  }
  else if (services.length > 0) {
    builder.element('services', nest: () {
      services.forEach((service) {
        builder.element('service', nest: service.serviceCode);
      });
    });
  }
}