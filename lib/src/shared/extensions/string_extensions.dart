import 'package:auto_cart/src/shared/constants/endpoints.dart';

extension StringExtensions on String {
  String get url => '${EndPoints.baseUrl}$this';
  String get imageUrl => '${EndPoints.imageBaseUrl}$this';

}