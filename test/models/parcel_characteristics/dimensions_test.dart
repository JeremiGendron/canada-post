import 'package:test/test.dart';

import 'package:divine_lilium/src/models/parcel_characteristics/dimensions.dart';

void main() {
  group('dimensions', () {
    test('valid', () {
      List<List<double>> cases = [
        [10.0, 15.0, 25.0],
        [200.0, 2000.0, 300.0],
        [437.9, 333.3, 847.7485]
      ];

      cases.forEach((dimensions) {
        Dimensions test = Dimensions(dimensions: dimensions);

        dimensions.sort();

        var formatted = dimensions.map((value) => value.toStringAsFixed(1));

        expect(formatted, [test.height, test.width, test.length]);
      });
    });
    test('invalid', () {
      List<List<double>> cases = [
        [1000.9, 10],
        [15.toDouble(), 25]
      ];

      cases.forEach((dimensions) {
        try {
          Dimensions test = Dimensions(dimensions: dimensions);
        } on ArgumentError catch (error) {
          expect(error.message,
              "Must provide length, width and height for dimensions. (3 doubles)");
        }
      });
    });
  });
  group('oversized', () {
    test("SHOULD be oversized", () {
      List<double> dimensions = [1000.0, 15.0, 300.0];

      Dimensions test = Dimensions(dimensions: dimensions);

      expect(test.oversized, true);
    });
    test("SHOULD NOT oversized", () {
      List<double> dimensions = [100.0, 15.0, 300.0];

      Dimensions test = Dimensions(dimensions: dimensions);

      expect(test.oversized, false);
    });
  });
}
