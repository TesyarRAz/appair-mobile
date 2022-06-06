import 'package:appair/entities/pagination.dart';
import 'package:appair/entities/transaksi.dart';

class ProfileData {
  final Pagination<Transaksi> listTransaksiResponse;

  ProfileData({required this.listTransaksiResponse});
}
