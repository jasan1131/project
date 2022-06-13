import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myappication_1/utility/my_constant.dart';

class BuyerMenuFood extends StatefulWidget {
  const BuyerMenuFood({Key? key}) : super(key: key);

  @override
  State<BuyerMenuFood> createState() => _BuyerMenuFoodState();
}

class _BuyerMenuFoodState extends State<BuyerMenuFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('menu food'),
    );
  }
}
