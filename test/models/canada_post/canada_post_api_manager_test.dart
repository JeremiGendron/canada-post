import 'dart:io';

import 'package:test/test.dart';

import 'package:divine_lilium/src/models/canada_post_api_manager/canada_post_api_manager.dart';

void main() {
  test("valid", () {
    CanadaPostApiManager manager = CanadaPostApiManager(
        baseUrl: "https://testing/",
        username: "36b0b7638bc6eb15",
        password: "2fceb9b3a1449294d6e395");

    print(manager);
    expect(manager.defaultHeaders["Authorization"],
        "Basic MzZiMGI3NjM4YmM2ZWIxNToyZmNlYjliM2ExNDQ5Mjk0ZDZlMzk1");
  });
  group("invalid", () {
    test("empty baseUrl", () {
      try {
        CanadaPostApiManager _ = CanadaPostApiManager(
            baseUrl: "", username: "unimportant", password: "anything");
      } on ArgumentError catch (error) {
        expect(error.message, "Can't provide empty baseUrl");
      }
    });
    test("baseUrl doesn't end with /", () {
      try {
        CanadaPostApiManager _ = CanadaPostApiManager(
            baseUrl: "testing", username: "unimportant", password: "anything");
      } on ArgumentError catch (error) {
        expect(error.message, "baseUrl must end with \"/\"");
      }
    });
    test("baseUrl doesn't start with https://", () {
      try {
        CanadaPostApiManager _ = CanadaPostApiManager(
            baseUrl: "testing/", username: "unimportant", password: "anything");
      } on ArgumentError catch (error) {
        expect(error.message, "baseUrl must start with https://");
      }
    });
  });
}
