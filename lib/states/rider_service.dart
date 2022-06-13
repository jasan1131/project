import 'package:flutter/material.dart';
import 'package:flutter_myappication_1/widgets/show_signout.dart';

class RiderService extends StatefulWidget {
  const RiderService({Key? key}) : super(key: key);

  @override
  State<RiderService> createState() => _RiderServiceState();
}

class _RiderServiceState extends State<RiderService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('rider'),
      ),
      drawer: Drawer(
        child: ShowSignOut(),
      ),
    );
  }
}
