import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';

class CanadaPostApiManager {
  final String baseUrl;
  Map<String, String> defaultHeaders = {};
  HttpClient client = HttpClient();

  /// USERNAME : PASSWORD (provided by Canada Post as the production or development Api Key)
  CanadaPostApiManager(
      {@required this.baseUrl,
      @required String username,
      @required String password}) {
    this.defaultHeaders["Authorization"] =
        parseAuthorization(username, password);
    this.defaultHeaders["Accept-Language"] = "en-CA";

    if (this.baseUrl == "") {
      throw ArgumentError("Can't provide empty baseUrl");
    } else if (!this.baseUrl.endsWith("/")) {
      throw ArgumentError("baseUrl must end with \"/\"");
    } else if (!this.baseUrl.contains(RegExp(r'https://'))) {
      throw ArgumentError("baseUrl must start with https://");
    }
  }
}

String parseAuthorization(String username, String password) {
  return 'Basic ' +
      Base64Encoder().convert(utf8.encode(username + ':' + password));
}
