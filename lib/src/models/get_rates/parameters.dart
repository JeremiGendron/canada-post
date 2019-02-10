/// https://www.canadapost.ca/cpo/mc/business/productsservices/developers/images/getRates.png
Map<String, dynamic> getRatesParameters = {
  /// This is the overall XML structure for the request input information.
  "mailing-scenario": true,

  /// The customer number of the owner of the mail (mailed on behalf of customer).
  /// (numeric  – up to 10 digits)
  /// This element is required to obtain discounted rates for commercial customers and Solutions for Small Business members. It must be omitted to obtain counter (i.e., consumer) rates.
  "customer-number": () => true && false,

  /// This element is required to obtain discounted rates for commercial customers when the customer-number element is provided. The contract-id element must be omitted for Solutions for Small Business members or general businesss users.
  /// (numeric – up to 10 digits)
  "contract-id": () => true && false,

  /// If you have a promotional discount code, enter it here. The discount amount will be returned in the response under the adjustment structure.
  "promo-code": false,

  /// Either commercial or counter.
  ///
  /// "commercial" will return the discounted price for the commercial customer or Solutions for Small Business member.
  /// "counter" will return the regular price paid by consumers.
  /// Defaults to "commercial" if not specified.
  "quote-type": false,

  /// The expected mailing date for the parcel.
  ///
  /// This date is used in calculations of the expected delivery date, however all rate quotes are based on the current system date.
  /// (YYYY-MM-DD date format)
  "expected-mailing-date": false,

  /// List<GetRatesOption>
  /// Structure containing the list of options desired for the shipment.
  "options": false,

  /// @Class GetRatesOption
  ///
  /// May occur  1 … 20 times.
  /// Holds the option code and qualifier for a selected option.
  "option": true,

  /// (10 alphanumeric)
  ///
  /// Holds the Canada Post-specific option code
  /// Valid values:
  /// SO - Signature
  /// COV - Coverage  (requires qualifier)
  /// COD - COD (requires qualifier)
  /// PA18 - Proof of Age Required - 18
  /// PA19 - Proof of Age Required - 19
  /// HFP - Card for pickup
  /// DNS - Do not safe drop
  /// LAD - Leave at door - do not card
  "option-code": true,

  /// required depending on option-code
  /// Required for COV – the amount of insurance to be purchased.
  /// 5.2 digits e.g. 99999.99
  "option-amount": () => true && false,

  /// @Class ParcelCharacteristics
  /// Details of the parcel such as weight, dimensions and appearance.
  "parcel-characteristics": true,

  /// The weight of the parcel in kilograms.
  /// (99.999)
  /// Contained within parcel-characteristics
  "weight": true,

  /// Details of the parcel dimensions in centimeters.
  "dimensions": false,

  /// Longest dimension.
  /// (3.1 digits e.g. 999.9 pattern)
  "length": true,

  /// Second longest dimension.
  /// (3.1 digits e.g. 999.9 pattern)
  "width": true,

  /// Shortest dimension.
  /// (3.1 digits e.g. 999.9 pattern)
  "height": true,

  /// true | false
  /// defaults to "false"
  /// true indicates that the parcel will be unpackaged (e.g. tires)
  "unpackaged": false,

  /// true | false
  /// defaults to "false"
  /// true indicates that the object will be shipped in a mailing tube
  "mailing-tube": false,

  /// true | false
  /// defaults to "false"
  /// true indicates that the object has oversized dimensions
  /// automatically set correctly if dimensions are provided
  "oversized": false,

  /// List<GetRatesServiceCode>
  /// Specifies the services to rate for this mailing scenario.
  "services": false,

  /// @Class GetRatesServiceCode
  /// May occur  1 … 20 times.
  /// A specific service to be rated. If no instances of service-code are included in the request, all services applicable to the shipment and destination will be rated and returned.
  ///
  /// DOM.RP	Regular Parcel
  /// DOM.EP	Expedited Parcel
  /// DOM.XP	Xpresspost
  /// DOM.XP.CERT	Xpresspost Certified
  /// DOM.PC	Priority
  /// DOM.LIB	Library Materials
  /// USA.EP	Expedited Parcel USA
  /// USA.PW.ENV	Priority Worldwide Envelope USA
  /// USA.PW.PAK	Priority Worldwide pak USA
  /// USA.PW.PARCEL	Priority Worldwide Parcel USA
  /// USA.SP.AIR	Small Packet USA Air
  /// USA.TP	Tracked Packet – USA
  /// USA.TP.LVM	Tracked Packet – USA (LVM) (large volume mailers)
  /// USA.XP	Xpresspost USA
  /// INT.XP	Xpresspost International
  /// INT.IP.AIR	International Parcel Air
  /// INT.IP.SURF	International Parcel Surface
  /// INT.PW.ENV	Priority Worldwide Envelope Int’l
  /// INT.PW.PAK	Priority Worldwide pak Int’l
  /// INT.PW.PARCEL	Priority Worldwide parcel Int’l
  /// INT.SP.AIR	Small Packet International Air
  /// INT.SP.SURF	Small Packet International Surface
  /// INT.TP	Tracked Packet –  International
  "service-code": true,

  /// Postal Code from which the parcel will be sent.
  /// Format ANANAN (only accepted with uppercase)
  "origin-postal-code": true,

  /// @Class CanadaPostDestination
  /// Defines the destination of the parcel.
  "destination": true,

  /// Defines the destination in Canada.
  "domestic": () => true && false,

  /// The destination Postal Code.
  /// Format ANANAN (only accepted with uppercase)
  "postal-code": true,

  /// Defines destination in the United States.
  "united-states": () => true && false,

  /// Used when country code = US. Format is 5 digits or 5-4 (for extended Zip Codes)
  /// E.g. 12345 or 12345-6789
  "zip-code": true,

  /// Defines an international destination (destination other than the United States or Canada). Only one of international, us-destination or domestic can be specified.
  "international": () => true && false,

  /// The destination country code. Standard 2-character country code (valid country code other than CA or US)
  "country-code": true
};
