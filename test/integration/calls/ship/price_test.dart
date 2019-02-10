import 'dart:io';
import 'dart:convert';

import 'package:test/test.dart';
import 'package:xml/xml.dart';

import 'package:divine_lilium/src/models/canada_post_api_manager/canada_post_api_manager.dart';
import 'package:divine_lilium/src/calls/ship/price.dart';
import 'package:divine_lilium/src/models/mailing_scenario/mailing_scenario.dart';

void main() {
  CanadaPostApiManager manager = CanadaPostApiManager(
    baseUrl: "https://ct.soa-gw.canadapost.ca/rs/",
    username: "36b0b7638bc6eb15",
    password: "2fceb9b3a1449294d6e395"
  );

  test('basic', () async {
    MailingScenario test = MailingScenario(
      destination: InternationalDestination(location: 'FR'),
      parcelCharacteristics: ParcelCharacteristics(
        dimensions: Dimensions(
          dimensions: [20.0, 20.8, 21.7]
        ),
        weight: 0.5009
      ),
      originPostalCode: "J7T3E1",
      options: [Option(optionCode: 'SO')],
      customerNumber: '0008795545'
    );

    PriceCaller caller = PriceCaller(manager: manager);

    XmlBuilder builder = XmlBuilder();
    buildMailingScenario(builder, test);
    String result = builder.build().toXmlString();

    HttpClientResponse response = await caller.shoot(test);
    response.transform(utf8.decoder).listen((contents) {
      print(contents);
    });
    print(response.toString());
  });
}