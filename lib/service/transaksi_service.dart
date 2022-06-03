import 'package:appair/entities/pagination.dart';
import 'package:appair/entities/transaksi.dart';
import 'package:appair/repository/transaksi_repository.dart';
import 'package:get/get.dart';

class TransaksiService extends GetxService {
  final TransaksiRepository repository;

  TransaksiService({required this.repository});

  Future<TransaksiActiveResponse> transaksiActive() async {
    var data = await repository.transaksiActive();

    return TransaksiActiveResponse.fromJson(data);
  }

  Future<Pagination<Transaksi>> history([String? cursor]) async {
    var pagination = await repository.history(cursor);

    if (pagination != null) {
      return Pagination(
        data: pagination.data.map((e) => Transaksi.fromJson(e)).toList(),
        nextCursor: pagination.nextCursor,
        path: pagination.path,
        perPage: pagination.perPage,
      );
    }

    return Pagination();
  }
}

class TransaksiActiveResponse {
  Transaksi? data;

  TransaksiActiveResponse({
    this.data,
  });

  factory TransaksiActiveResponse.fromJson(Map<String, dynamic> json) => TransaksiActiveResponse(
    data: json['data'] != null ? Transaksi.fromJson(json["data"]) : null,
  );
}