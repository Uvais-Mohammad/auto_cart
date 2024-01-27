// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'dart:async';

import 'package:auto_cart/src/shared/enums/load_type.dart';
import 'package:auto_cart/src/shared/utils/pagination/pagination_response.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod/src/async_notifier.dart';

// ignore: invalid_use_of_internal_member
mixin PaginationController<T> on AsyncNotifierBase<PaginationResponse<T>> {
  FutureOr<PaginationResponse<T>> loadData({required int index,LoadingType loadingType=LoadingType.initial});

  Future<void> loadMore(LoadingType type) async {
    final oldState = state;
    if (oldState.requireValue.isCompleted) return;
    state = AsyncLoading<PaginationResponse<T>>().copyWithPrevious(oldState);
    state = await AsyncValue.guard<PaginationResponse<T>>(() async {
      final res = await loadData(index: oldState.requireValue.nextPageIndex,loadingType: type);
      res.data.insertAll(0, state.requireValue.data);
      return res;
    });
  }

  bool canLoadMore() {
    if (state.isLoading) return false;
    if (!state.hasValue) return false;
    if (state.requireValue.isCompleted) return false;
    return true;
  }
}
