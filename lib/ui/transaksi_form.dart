import 'package:flutter/material.dart';
import 'package:keuanganpribadi/bloc/transaksi_bloc.dart';
import 'package:keuanganpribadi/model/transaksi.dart';
import 'package:keuanganpribadi/ui/transaksi_page.dart';
import 'package:keuanganpribadi/widget/warning_dialog.dart';

class TransaksiForm extends StatefulWidget {
  Transaksi? transaksi;

  TransaksiForm({Key? key, this.transaksi}) : super(key: key);

  @override
  _TransaksiFormState createState() => _TransaksiFormState();
}

class _TransaksiFormState extends State<TransaksiForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH TRANSAKSI";
  String tombolSubmit = "SIMPAN";

  final _kodeTransaksiTextboxController = TextEditingController();
  final _namaTransaksiTextboxController = TextEditingController();
  final _nominalTransaksiTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.transaksi != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _kodeTransaksiTextboxController.text = widget.transaksi!.kodeTransaksi!;
        _namaTransaksiTextboxController.text = widget.transaksi!.namaTransaksi!;
        _nominalTransaksiTextboxController.text =
            widget.transaksi!.nominalTransaksi.toString();
      });
    } else {
      judul = "TAMBAH TRANSAKSI";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeTransaksiTextField(),
                _namaTransaksiTextField(),
                _nominalTransaksiTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Kode Transaksi
  Widget _kodeTransaksiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kode Transaksi"),
      keyboardType: TextInputType.text,
      controller: _kodeTransaksiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Transaksi harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Nama Transaksi
  Widget _namaTransaksiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Transaksi"),
      keyboardType: TextInputType.text,
      controller: _namaTransaksiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Transaksi harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Nominal Transaksi

  Widget _nominalTransaksiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nominal"),
      keyboardType: TextInputType.number,
      controller: _nominalTransaksiTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nominal harus diisi";
        }

        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.transaksi != null) {
                //kondisi update produk
                ubah();
              } else {
                //kondisi tambah produk
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Transaksi createTransaksi = Transaksi(id: null);
    createTransaksi.kodeTransaksi = _kodeTransaksiTextboxController.text;
    createTransaksi.namaTransaksi = _namaTransaksiTextboxController.text;
    createTransaksi.nominalTransaksi = int.parse(_nominalTransaksiTextboxController.text);
    TransaksiBloc.addTransaksi(transaksi: createTransaksi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TransaksiPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Simpan gagal, silahkan coba lagi",
          ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Transaksi updateTransaksi = Transaksi(id: null);
    updateTransaksi.id = widget.transaksi!.id;
    updateTransaksi.kodeTransaksi = _kodeTransaksiTextboxController.text;
    updateTransaksi.namaTransaksi = _namaTransaksiTextboxController.text;
    updateTransaksi.nominalTransaksi = int.parse(_nominalTransaksiTextboxController.text);
    TransaksiBloc.updateTransaksi(transaksi: updateTransaksi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const TransaksiPage(),
      ));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
}
