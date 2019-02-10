import 'dart:io';

import 'package:xml/xml.dart';

import 'package:divine_lilium/src/models/canada_post_api_manager/canada_post_api_manager.dart';
import 'package:divine_lilium/src/models/canada_post_call/canada_post_call.dart';
import 'package:divine_lilium/src/models/mailing_scenario/mailing_scenario.dart';

class PriceCaller extends CanadaPostCall {

  PriceCaller({
    CanadaPostApiManager manager
  }) : super(
    endpoint: "ship/price",
    manager: manager, 
    method: 'POST',
    headers: {
      "Content-Type": "application/vnd.cpc.ship.rate-v3+xml",
      "Accept": "application/vnd.cpc.ship.rate-v3+xml"
    });

  Future<HttpClientResponse> shoot(MailingScenario mailingScenario) {
    XmlBuilder builder = XmlBuilder();
    buildMailingScenario(builder, mailingScenario);

    String xml = builder.build().toXmlString();
    print(xml);
    return super.call(xml);
  }
}