import 'package:appair/common/entities/pagination.dart';
import 'package:appair/common/entities/transaksi.dart';

class ProfileData {
  final Pagination<Transaksi> listTransaksiResponse;

  ProfileData({required this.listTransaksiResponse});
}
