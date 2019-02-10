import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

import 'package:divine_lilium/src/models/parcel_characteristics/parcel_characteristics.dart';

import './destination.dart';
import './option.dart';
import './service.dart';

export './destination.dart';
export './option.dart';
export './service.dart';
export 'package:divine_lilium/src/models/parcel_characteristics/parcel_characteristics.dart';

class MailingScenario {
  final Destination destination;
  final ParcelCharacteristics parcelCharacteristics;
  final String originPostalCode;
  List<Service> services;
  final List<Option> options;
  final String
      contractId; // required for commercial discounts that AREN'T small or general business
  final String
      promoCode; // the discounted rate will be returned under the "adjustment" structure when provided
  String
      customerNumber; // required if quoteType commercial, must be null otherwise
  String quoteType; // D"commercial" || "counter"
  String
      expectedMailingDate; // D"YYYY/MM/DD" (tomorrow) -- can't be in the past

  MailingScenario(
      {@required this.destination,
      @required this.parcelCharacteristics,
      @required this.originPostalCode,
      @required this.options,
      this.services,
      this.contractId,
      this.promoCode,
      this.customerNumber,
      this.expectedMailingDate,
      this.quoteType = "commercial"}) {
    if (this.options.length < 1 || this.options.length > 20) {
      throw ArgumentError("incorrect number of options provided: min. 1, max. 20");
    }

    if (this.customerNumber != null && this.quoteType == "counter") {
      throw ArgumentError(
          "can't provide a customerNumber for a quoteType \"counter\"");
    } else if (this.customerNumber == null && this.quoteType == "commercial") {
      throw ArgumentError('quoteType "commercial" requries a customerNumber');
    }

    if (this.expectedMailingDate == null) {
      this.expectedMailingDate =
          currentDateFormatted(DateTime.now().add(Duration(days: 1)));
    }

    if (this.quoteType != "commercial" && this.quoteType != "counter") {
      throw ArgumentError('quoteType must be "commercial" or "counter".');
    }
  }
}

String currentDateFormatted(DateTime date) {
  return date.year.toString() + '-' +
      (date.month < 10 ? '0' + date.month.toString() : date.month.toString()) + '-' +
      (date.day < 10 ? '0' + date.day.toString() : date.day.toString());
}

buildMailingScenario(XmlBuilder builder, MailingScenario mailingScenario) {
  builder.element('mailing-scenario', nest: () {
    builder.namespace("http://www.canadapost.ca/ws/ship/rate-v3");

    buildOriginPostalCode(builder, mailingScenario);
    buildExpectedMailingDate(builder, mailingScenario);
    buildQuoteType(builder, mailingScenario);
    buildContractId(builder, mailingScenario);
    buildCustomerNumber(builder, mailingScenario);
    buildPromoCode(builder, mailingScenario);
    buildOptions(builder, mailingScenario.options);
    buildServices(builder, mailingScenario.services);
    buildDestination(builder, mailingScenario.destination);
    buildParcelCharacteristics(builder, mailingScenario.parcelCharacteristics);
  });
}

void buildPromoCode(XmlBuilder builder, MailingScenario mailingScenario) {
  if (mailingScenario.promoCode != null)
    builder.element('promo-code', nest: () {
      builder.text(mailingScenario.promoCode);
    });
}
void buildOriginPostalCode(XmlBuilder builder, MailingScenario mailingScenario) {
  builder.element('origin-postal-code', nest: () {
      builder.text(mailingScenario.originPostalCode);
  });
}
void buildExpectedMailingDate(XmlBuilder builder, MailingScenario mailingScenario) {
  builder.element('expected-mailing-date', nest: () {
    builder.text(mailingScenario.expectedMailingDate);
  });
}
void buildQuoteType(XmlBuilder builder, MailingScenario mailingScenario) {
  builder.element('quote-type', nest: () {
    builder.text(mailingScenario.quoteType);
  });
}
void buildContractId(XmlBuilder builder, MailingScenario mailingScenario) {
  if (mailingScenario.contractId != null)
    builder.element('contract-id', nest: () {
      builder.text(mailingScenario.contractId);
    });
}  
void buildCustomerNumber(XmlBuilder builder, MailingScenario mailingScenario) {
  if (mailingScenario.customerNumber != null)
    builder.element('customer-number', nest: () {
      builder.text(mailingScenario.customerNumber);
    });
}
