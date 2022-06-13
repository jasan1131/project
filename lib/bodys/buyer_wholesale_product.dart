import 'package:flutter/material.dart';

class BuyerWholeSaleProduct extends StatefulWidget {
  const BuyerWholeSaleProduct({ Key? key }) : super(key: key);

  @override
  State<BuyerWholeSaleProduct> createState() => _BuyerWholeSaleProductState();
}

class _BuyerWholeSaleProductState extends State<BuyerWholeSaleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('WholeSale Product'),
    );
  }
}