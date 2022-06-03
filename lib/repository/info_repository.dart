
import 'package:appair/entities/pagination.dart';
import 'package:appair/repository/repository.dart';

class InfoRepository extends Repository {
  InfoRepository({required super.baseUrl});

  Future<Pagination<Map<String, dynamic>>?> list([String? cursor]) async {
    var response = await get("/info?cursor=$cursor");

    if (response.statusCode == 200) {
      return Pagination.fromJson(response.body);
    }

    return null;
  }
}