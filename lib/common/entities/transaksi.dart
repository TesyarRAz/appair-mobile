class Transaksi {
  int id;
  String kode;
  String? buktiBayar;
  String status;

  String? tanggalBayar;
  String? tanggalTempo;
  int? totalHarga;
  int? totalBayar;
  String? keteranganDitolak;

  Transaksi({
    required this.id,
    required this.kode,
    required this.buktiBayar,
    required this.status,
    required this.tanggalBayar,
    required this.tanggalTempo,
    required this.totalHarga,
    required this.totalBayar,
    required this.keteranganDitolak,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        id: json["id"],
        kode: json["kode"],
        buktiBayar: json["bukti_bayar"],
        status: json["status"],
        tanggalBayar: json["tanggal_bayar"],
        tanggalTempo: json["tanggal_tempo"],
        totalHarga: json["total_harga"],
        totalBayar: json["total_bayar"],
        keteranganDitolak: json["keterangan_ditolak"],
      );

  String get statusText {
    switch (status) {
      case "belum_bayar":
        return "Belum Bayar";
      case "diterima":
        return "Diterima";
      case "ditolak":
        return "Ditolak";
      case "lewati":
        return "Dilewati";
      case "lunas":
        return "Lunas";
      default:
        return "";
    }
  }
}
