import 'package:flutter/material.dart';
import 'package:keuanganpribadi/bloc/transaksi_bloc.dart';
import 'package:keuanganpribadi/model/transaksi.dart';
import 'package:keuanganpribadi/ui/transaksi_form.dart';
import 'package:keuanganpribadi/ui/transaksi_page.dart';
import 'package:keuanganpribadi/widget/warning_dialog.dart';

class TransaksiDetail extends StatefulWidget {
  final Transaksi? transaksi;

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
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.blue,
                Colors.green,
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Kode", widget.transaksi!.kodeTransaksi ?? ""),
            _buildDetailRow("Nama", widget.transaksi!.namaTransaksi ?? ""),
            _buildDetailRow(
              "Nominal",
              "Rp. ${widget.transaksi!.nominalTransaksi.toString()}",
            ),
            const SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }


  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransaksiForm(
                  transaksi: widget.transaksi,
                ),
              ),
            );
          },
          child: const Text("Edit"),
        ),
        ElevatedButton(
          onPressed: () => _showDeleteConfirmationDialog(),
          style: ElevatedButton.styleFrom(primary: Colors.red),
          child: const Text("Delete"),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Yakin ingin menghapus data ini?"),
        actions: [
          ElevatedButton(
            onPressed: () {
              int transaksiId = widget.transaksi!.id!;
              hapus(transaksiId);
              Navigator.pop(context);
            },
            child: const Text("Ya"),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
        ],
      ),
    );
  }

  void hapus(int id) {
    TransaksiBloc.deleteTransaksi(id: id).then((bool success) {
      if (success) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const TransaksiPage(),
          ),
        );
      } else {
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
