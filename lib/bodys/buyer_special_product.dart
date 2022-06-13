import 'package:flutter/material.dart';
import 'package:flutter_myappication_1/utility/my_constant.dart';
import 'package:flutter_myappication_1/widgets/show_title.dart';

class BuyerSpecialProduct extends StatefulWidget {
  const BuyerSpecialProduct({Key? key}) : super(key: key);

  @override
  State<BuyerSpecialProduct> createState() => _BuyerSpecialProductState();
}

class _BuyerSpecialProductState extends State<BuyerSpecialProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('special product'),
    );
  }
}
