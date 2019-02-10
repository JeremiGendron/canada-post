import 'package:test/test.dart';

import 'package:divine_lilium/src/models/parcel_characteristics/parcel_characteristics.dart';
import 'package:divine_lilium/src/models/parcel_characteristics/dimensions.dart';

void main() {
  group("optionals", () {
    test("SHOULD have falsy default values", () {
      List<double> dimensions = [23.9, 54, 22];
      Dimensions testDimensions = Dimensions(dimensions: dimensions);
      ParcelCharacteristics test = ParcelCharacteristics(
        dimensions: testDimensions,
        weight: 1.57,
      );

      expect([test.mailingTube, test.unpackaged], [false, false]);
    });
    test("SHOULD fail for unpackaged and mailingTube set to true", () {
      List<double> dimensions = [23.9, 54, 22];
      Dimensions testDimensions = Dimensions(dimensions: dimensions);

      try {
        ParcelCharacteristics test = ParcelCharacteristics(
            dimensions: testDimensions,
            weight: 1.57,
            mailingTube: true,
            unpackaged: true);
      } on ArgumentError catch (error) {
        expect(error.message,
            "Parcel can't be both unpackaged and in a mailingTube");
      }
    });
    test("SHOULD properly set unpackaged or mailingTube to true", () {
      List<double> dimensions = [23.9, 54, 22];
      Dimensions testDimensions = Dimensions(dimensions: dimensions);

      ParcelCharacteristics test1 = ParcelCharacteristics(
          dimensions: testDimensions, weight: 1.57, mailingTube: true);

      ParcelCharacteristics test2 = ParcelCharacteristics(
          dimensions: testDimensions,
          weight: 1.57,
          mailingTube: false,
          unpackaged: true);
    });
  });
  group("weight", () {
    test("SHOULD be OK", () {
      List<double> dimensions = [1000.74, 4000.3, 20.9];
      Dimensions testDimensions = Dimensions(dimensions: dimensions);

      ParcelCharacteristics test =
          ParcelCharacteristics(dimensions: testDimensions, weight: 99.99900);

      expect(test.weight, "99.999");
    });
    test("SHOULD NOT be OK", () {
      List<double> dimensions = [1000.74, 4000.3, 20.9];
      Dimensions testDimensions = Dimensions(dimensions: dimensions);

      try {
        ParcelCharacteristics test =
            ParcelCharacteristics(dimensions: testDimensions, weight: 99.99900);
      } on ArgumentError catch (error) {
        expect(error.message, "Weight must not exceed 99.999 kg");
      }
    });
  });
  group("oversized dimensions", () {
    test("SHOULD be oversized", () {
      List<double> dimensions = [1000.0, 15.0, 300.0];
      Dimensions testDimensions = Dimensions(dimensions: dimensions);

      ParcelCharacteristics test =
          ParcelCharacteristics(dimensions: testDimensions, weight: 80.0);

      expect(test.oversized, true);
    });
    test("SHOULD NOT be oversized", () {
      List<double> dimensions = [999.0, 15.0, 300.0];
      Dimensions testDimensions = Dimensions(dimensions: dimensions);

      ParcelCharacteristics test =
          ParcelCharacteristics(dimensions: testDimensions, weight: 80.0);

      expect(test.oversized, false);
    });
  });
}
