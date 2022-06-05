import 'package:appair/entities/pagination.dart';
import 'package:appair/repository/repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TransaksiRepository extends AuthorizedRepository {
  TransaksiRepository({required super.baseUrl});

  Future<Map<String, dynamic>> transaksiActive() async {
    var response =
        await get('/transaksi?type=active').catchError((error) => throw error);

    if (response.statusCode == 200) {
      return response.body;
    }

    return {};
  }

  Future<Pagination<Map<String, dynamic>>?> history([String? cursor]) async {
    var response = await get('/transaksi?cursor=$cursor')
        .catchError((error) => throw error);

    if (response.statusCode == 200) {
      return Pagination.fromJson(response.body);
    }

    return null;
  }

  Future<Map<String, dynamic>> bayar(List<int> file, int kubik, String filename) async {
    var formData = FormData.fromMap({
      'bukti_bayar': MultipartFile.fromBytes(file, filename: filename),
      'kuantitas': kubik,
    });

    var response = await dio().post("/transaksi/bayar", data: formData)
        .catchError((error) => throw error);

    debugPrint(response.data.toString());

    if (response.statusCode == 200) {
      return response.data;
    }

    return {};
  }
}
