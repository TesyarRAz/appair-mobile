import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BayarPage extends StatelessWidget {
  const BayarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Air'),
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Harga',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Rp. 10.000 / Kubik',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Tanah Kamu',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Masukkan jumlah kubik',
                      ),
                      keyboardType: TextInputType.numberWithOptions(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Total Harga : Rp. 10.000',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Ubuntu',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(200),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Silahkan Melakukan Pembayaran",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rekening",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "BCA : 08123912321",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                          Text(
                            "Mandiri : 1232193123",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: Text(
                  "Upload Bukti Pembayaran",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Ubuntu',
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  minimumSize: MaterialStateProperty.all(Size.fromHeight(50)),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
