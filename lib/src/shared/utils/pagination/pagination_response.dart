
class PaginationResponse<T> {
  final int index;
  final List<T> data;
  final bool isCompleted;
  
  const PaginationResponse({
    this.index = 0,
    required this.data,
    this.isCompleted = false,
  });

  int get nextPageIndex => index + 1;
}