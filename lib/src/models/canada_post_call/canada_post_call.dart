import 'dart:async';
import 'dart:io';

import 'package:meta/meta.dart';

import 'package:divine_lilium/src/models/canada_post_api_manager/canada_post_api_manager.dart';

abstract class CanadaPostCall {
  final HttpClient client;
  final String method;
  final Uri url;
  Map<String, String> headers;

  CanadaPostCall(
      {@required CanadaPostApiManager manager,
      @required String endpoint,
      @required Map<String, String> this.headers,
      @required this.method})
      : this.client = manager.client,
        this.url = Uri.parse(manager.baseUrl + endpoint) {
    this.headers["Authorization"] =
        manager.defaultHeaders["Authorization"];
    this.headers["Accept-Language"] =
        manager.defaultHeaders["Accept-Language"];
  }

  Future<HttpClientResponse> call(String body) async {
    HttpClientRequest request = this.method == 'GET'
    ? await this.client.getUrl(this.url)
    : await this.client.postUrl(this.url);

    this.headers.forEach((key, value) {
      request.headers.set(key, value);
    });

    request.headers.set("Content-Length", body.length);

    if (body != null) request.write(body);

    print(request.uri);
    print(body);
    return request.close();
  }
}
