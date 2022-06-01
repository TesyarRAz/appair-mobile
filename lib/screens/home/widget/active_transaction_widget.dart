import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ActiveTransactionWidget extends StatelessWidget {
  const ActiveTransactionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox.fromSize(
        size: const Size.fromHeight(150),
        child: Card(
          elevation: 10,
          child: Column(
            children: [
              Row(),
            ],
          ),
        ),
      ),
    );
  }
}