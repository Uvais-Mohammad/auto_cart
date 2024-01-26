import 'package:auto_cart/src/features/home/repository/i_home_repo.dart';
import 'package:auto_cart/src/shared/services/http_service/http_servide.dart';
import 'package:auto_cart/src/shared/services/http_service/i_http_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final termsAndConditionRepositoryProvider =
    Provider<ITermsAndConditionRepository>(
  (ref) => TermsAndConditionRepository(
    httpService: ref.read(httpServiceProvider),
  ),
);

final class TermsAndConditionRepository
    implements ITermsAndConditionRepository {
  final IHttpService _httpService;

  TermsAndConditionRepository({
    required IHttpService httpService,
  }) : _httpService = httpService;
}
