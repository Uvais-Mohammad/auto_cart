import 'dart:convert';

import 'package:auto_cart/src/shared/services/http_service/i_http_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final httpServiceProvider = Provider<IHttpService>(
  (ref) => HttpService(),
);

final class HttpService implements IHttpService {
  @override
  Future<http.Response> get(String url) async {
    return http.get(Uri.parse(url));
  }

  @override
  Future<http.Response> post(String url, {Map<String, dynamic>? body}) async {
    return http.post(
      Uri.parse(url),
      body: jsonEncode(body)
    );
  }
}
