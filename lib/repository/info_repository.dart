import 'dart:convert';

import 'package:appair/entities/info.dart';
import 'package:appair/repository/repository.dart';

class ListInfoResponse {
  final List<Info> data;
  final String path;
  final int perPage;
  final String nextCursor;

  ListInfoResponse({
    required this.data,
    required this.path,
    required this.perPage,
    required this.nextCursor,
  });

  factory ListInfoResponse.fromJson(Map<String, dynamic> json) => ListInfoResponse(
    data: List<Info>.from(json["data"].map((x) => Info.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    nextCursor: json["next_cursor"],
  );
}

class InfoRepository extends Repository {
  InfoRepository({required super.baseUrl});

  Future<ListInfoResponse?> getList([String? pageUrl]) async {
    pageUrl ??= '/info';

    var response = await get(pageUrl);

    if (response.statusCode == 200) {
      var data = await response.body;

      return ListInfoResponse.fromJson(data);
    }

    return null;
  }
}