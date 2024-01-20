class Transaksi {
  int? id;
  String? kodeTransaksi;
  String? namaTransaksi;
  int? nominalTransaksi;

  Transaksi({this.id, this.kodeTransaksi, this.namaTransaksi, this.nominalTransaksi});

  factory Transaksi.fromJson(Map<String, dynamic> obj) {
    return Transaksi(
        id: int.tryParse(obj['id'].toString()),
        kodeTransaksi: obj['kode_transaksi'],
        namaTransaksi: obj['nama_transaksi'],
      nominalTransaksi: int.tryParse(obj['nominal'].toString()), // Safely parse to int
    );
  }
}