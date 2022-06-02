import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListTransaksiPage extends StatelessWidget {
  const ListTransaksiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Air"),
        leading: const BackButton(),
      ),
      body: Center(
        child: Text('List Transaksi'),
      ),
    );
  }
}