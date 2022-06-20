import 'dart:typed_data';

import 'package:appair/common/entities/pagination.dart';
import 'package:appair/common/entities/transaksi.dart';
import 'package:appair/common/repository/transaksi_repository.dart';
import 'package:get/get.dart';

class TransaksiService extends GetxService {
  final TransaksiRepository repository;

  TransaksiService({required this.repository});

  Future<TransaksiActiveResponse> transaksiActive() async {
    var data = await repository.transaksiActive();

    return TransaksiActiveResponse.fromJson(data);
  }

  Future<Pagination<Transaksi>> history([String? cursor]) async {
    var pagination = await repository.history(cursor).catchError((error) => throw error);

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

  Future<TransaksiBayarResponse> bayar(List<int> file, int kubik, String filename) async {
    var data = await repository.bayar(file, kubik, filename).catchError((error) => throw error);
 
    return TransaksiBayarResponse.fromJson(data);
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

class TransaksiBayarResponse {
  bool success;
  Transaksi? data;

  TransaksiBayarResponse({
    this.success = false,
    this.data,
  });

  factory TransaksiBayarResponse.fromJson(Map<String, dynamic> json) => TransaksiBayarResponse(
    success: json['status'] == 'success',
    data: json['data'] != null ? Transaksi.fromJson(json["data"]) : null,
  );
}