import 'package:appair/entities/pagination.dart';
import 'package:appair/entities/transaksi.dart';
import 'package:appair/repository/repository.dart';

class TransaksiRepository extends AuthorizedRepository {
  TransaksiRepository({required super.baseUrl, required super.authToken});

  Future<Map<String, dynamic>> transaksiActive() async {
    var response = await get('/transaksi?type=active').catchError((error) => throw error);

    if (response.statusCode == 200) {
      return response.body;
    }

    return {};
  }

  Future<Pagination<Map<String, dynamic>>?> history([String? cursor]) async {
    var response = await get('/transaksi?cursor=$cursor').catchError((error) => throw error);

    if (response.statusCode == 200) {
      return Pagination.fromJson(response.body);
    }

    return null;
  }
}