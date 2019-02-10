import 'dart:io';
import 'package:meta/meta.dart';
import 'package:divine_lilium/src/models/parcel_characteristics/parcel_characteristics.dart';
import 'package:divine_lilium/src/models/mailing_scenario/mailing_scenario.dart';

const Map<String, String> getRatesHeaders = {
  HttpHeaders.acceptHeader: "application/vnd.cpc.ship.rate-v3+xml",
  HttpHeaders.contentTypeHeader: "application/vnd.cpc.ship.rate-v3+xml",
  HttpHeaders.authorizationHeader: "Basic",
  HttpHeaders.acceptLanguageHeader: "en-CA"
};

class GetRatesOption {}
