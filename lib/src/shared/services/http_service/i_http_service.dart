import 'package:http/http.dart';

abstract interface class IHttpService {
  Future<Response> get(String url);
}