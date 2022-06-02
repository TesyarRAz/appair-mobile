import 'package:appair/entities/transaksi.dart';
import 'package:appair/repository/repository.dart';
import 'package:flutter/material.dart';

class TransaksiNowResponse {
  Transaksi? data;

  TransaksiNowResponse({
    this.data,
  });

  factory TransaksiNowResponse.fromJson(Map<String, dynamic> json) => TransaksiNowResponse(
    data: json['data'] != null ? Transaksi.fromJson(json["data"]) : null,
  );
}

class TransaksiRepository extends AuthorizedRepository {
  TransaksiRepository({required super.baseUrl, required super.userToken});

  Future<TransaksiNowResponse> transaksiNow() async {
    var response = await get("/user/transaksi?type=check_now");

    if (response.statusCode == 200) {
      return TransaksiNowResponse.fromJson(response.body);
    }

    return TransaksiNowResponse();
  }
}