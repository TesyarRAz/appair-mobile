import 'package:appair/common/entities/info.dart';
import 'package:appair/common/entities/pagination.dart';
import 'package:appair/common/repository/info_repository.dart';
import 'package:get/get.dart';

class InfoService extends GetxService {
  final InfoRepository repository;

  InfoService({required this.repository});

  Future<Pagination<Info>?> list([String? cursor]) async {
    var pagination = await repository.list(cursor);

    if (pagination != null) {
      return Pagination(
        data: pagination.data.map((e) => Info.fromJson(e)).toList(),
        nextCursor: pagination.nextCursor,
        path: pagination.path,
        perPage: pagination.perPage,
      );
    }

    return null;
  }
}