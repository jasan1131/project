import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myappication_1/models/user_models.dart';
import 'package:flutter_myappication_1/utility/my_constant.dart';
import 'package:flutter_myappication_1/widgets/show_progress.dart';
import 'package:flutter_myappication_1/widgets/show_title.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowManageAdmin extends StatefulWidget {

  const ShowManageAdmin({Key? key}) : super(key: key);

  @override
  State<ShowManageAdmin> createState() => _ShowManageAdminState();
}

class _ShowManageAdminState extends State<ShowManageAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
