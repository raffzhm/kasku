import 'package:flutter/material.dart';
import 'package:keuanganpribadi/bloc/transaksi_bloc.dart';
import 'package:keuanganpribadi/model/transaksi.dart';
import 'package:keuanganpribadi/ui/transaksi_form.dart';
import 'package:keuanganpribadi/ui/transaksi_page.dart';
import 'package:keuanganpribadi/widget/warning_dialog.dart';

class TransaksiDetail extends StatefulWidget {
  Transaksi?  transaksi;

  TransaksiDetail({Key? key, this.transaksi}) : super(key: key);

  @override
  _TransaksiDetailState createState() => _TransaksiDetailState();

}

class _TransaksiDetailState extends State<TransaksiDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${widget.transaksi!.kodeTransaksi}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.transaksi!.namaTransaksi}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Nominal : Rp. ${widget.transaksi!.nominalTransaksi.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Edit
        OutlinedButton(
            child: const Text("EDIT"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransaksiForm(
                        transaksi: widget.transaksi,
                      )));
            }),
        //Tombol Hapus
        OutlinedButton(
            child: const Text("DELETE"), onPressed: () => confirmHapus()),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            int transaksiId = widget.transaksi!.id!;
            hapus(transaksiId);
            Navigator.pop(context);
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );


    showDialog(builder: (context) => alertDialog, context: context);
  }

  hapus(int id) {
    TransaksiBloc.deleteTransaksi(id: id).then((bool success) {

      if (success) {
        // Jika penghapusan berhasil, bisa tambahkan logika atau tindakan lainnya
        print("Transaksi berhasil dihapus");

        // Contoh: Navigasi ke halaman lain setelah penghapusan
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const TransaksiPage()));
      } else {
        // Jika penghapusan gagal, tampilkan pesan kesalahan
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Hapus gagal, silahkan coba lagi",
          ),
        );
      }
    });
  }

}