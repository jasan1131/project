import 'package:flutter/material.dart';

class ShowOrderAdmin extends StatefulWidget {
  const ShowOrderAdmin({ Key? key }) : super(key: key);

  @override
  State<ShowOrderAdmin> createState() => _ShowOrderAdminState();
}

class _ShowOrderAdminState extends State<ShowOrderAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('this is Show order'),
    );
  }
}