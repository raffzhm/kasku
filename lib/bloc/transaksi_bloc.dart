import 'dart:convert';

import 'package:keuanganpribadi/helpers/api.dart';
import 'package:keuanganpribadi/helpers/api_url.dart';
import 'package:keuanganpribadi/model/transaksi.dart';

class TransaksiBloc {
  static Future<List<Transaksi>> getTransaksis() async {
    Uri apiUrl = Uri.parse(ApiUrl.listTransaksi); // Use Uri.parse to convert to Uri
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listTransaksi = (jsonObj as Map<String, dynamic>)['data'];
    List<Transaksi> transaksis = [];
    for (int i = 0; i < listTransaksi.length; i++) {
      transaksis.add(Transaksi.fromJson(listTransaksi[i]));
    }
    return transaksis;
  }


  static Future addTransaksi({Transaksi? transaksi}) async {
    String apiUrl = ApiUrl.createTransaksi;

    var body = {
      "kode_transaksi": transaksi!.kodeTransaksi,
      "nama_transaksi": transaksi.namaTransaksi,
      "nominal": transaksi.nominalTransaksi.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateTransaksi({required Transaksi transaksi}) async {
    String apiUrl = ApiUrl.updateTransaksi(transaksi.id!);

    var body = {
      "kode_transaksi": transaksi.kodeTransaksi,
      "nama_transaksi": transaksi.namaTransaksi,
      "nominal": transaksi.nominalTransaksi.toString()
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['data'];
  }

  static Future<bool> deleteTransaksi({int? id}) async {
    String apiUrl = ApiUrl.deleteTransaksi(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}