import 'package:flutter/material.dart';
import 'package:keuanganpribadi/model/transaksi.dart';
import 'package:keuanganpribadi/ui/transaksi_detail.dart';
import 'package:keuanganpribadi/ui/transaksi_form.dart';

import '../bloc/logout_bloc.dart';
import '../bloc/transaksi_bloc.dart';
import 'login_page.dart';


class TransaksiPage extends StatefulWidget {
  const TransaksiPage({Key? key}) : super(key: key);

  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Transaksi Keuangan'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TransaksiForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const LoginPage()))
                });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: TransaksiBloc.getTransaksis(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListTransaksi(
            list: snapshot.data,
          )
              : const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ListTransaksi extends StatelessWidget {
  final List? list;

  const ListTransaksi({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemTransaksi(
            transaksi: list![i],
          );
        });
  }
}

class ItemTransaksi extends StatelessWidget {
  final Transaksi transaksi;

  const ItemTransaksi({Key? key, required this.transaksi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransaksiDetail(
                  transaksi: transaksi,
                )));
      },
      child: Card(
        child: ListTile(
          title: Text(transaksi.namaTransaksi!),
          subtitle: Text(transaksi.nominalTransaksi.toString()),
        ),
      ),
    );
  }
}
