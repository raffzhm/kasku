class Transaksi {
  int? code;
  int? id;
  String? kodeTransaksi;
  String? namaTransaksi;
  int? nominalTransaksi;

  Transaksi({this.code, this.id, this.kodeTransaksi, this.namaTransaksi, this.nominalTransaksi});

  factory Transaksi.fromJson(Map<String, dynamic> obj) {
    return Transaksi(
        code: obj['code'],
        kodeTransaksi: obj['kode_transaksi'],
        namaTransaksi: obj['nama_transaksi'],
      nominalTransaksi: int.tryParse(obj['nominal'].toString()), // Safely parse to int
    );
  }
}