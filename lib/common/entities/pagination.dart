class Pagination<T> {
  final List<T> data;
  final String? path;
  final int? perPage;
  final String? nextCursor;

  Pagination({
    this.data = const [],
    this.path,
    this.perPage,
    this.nextCursor,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    data: List<T>.from(json["data"].map((x) => x)),
    path: json["path"],
    perPage: json["per_page"],
    nextCursor: json["next_cursor"],
  );

  bool get isEmpty => data.isEmpty;
  bool get isNotEmpty => data.isNotEmpty;
}