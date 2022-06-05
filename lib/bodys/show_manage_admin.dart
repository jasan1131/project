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
  final UserMOdel userMOdel;
  const ShowManageAdmin({Key? key, required this.userMOdel}) : super(key: key);

  @override
  State<ShowManageAdmin> createState() => _ShowManageAdminState();
}

class _ShowManageAdminState extends State<ShowManageAdmin> {
  UserMOdel? userMOdel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userMOdel = widget.userMOdel;
  }

  Future<Null> refreshUserModel() async {
    print('## refreshUserModel Work');
    String apiGetUserWhereId = '${MyConstant.domain}/shopping/getUserWhereId.php?isAdd=true&id=${userMOdel!.id}';
    await Dio().get(apiGetUserWhereId).then((value) {
      for (var item in json.decode(value.data)) {
        setState(() {
          userMOdel = UserMOdel.fromMap(item);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.primary,
        child: Icon(Icons.edit),
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.rounteEditProfileAdmin)
                .then((value) => refreshUserModel()),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShowTitle(
                  title: 'Name Shop :',
                  textStyle: MyConstant().h2Style(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ShowTitle(
                        title: userMOdel!.name,
                        textStyle: MyConstant().h1Style(),
                      ),
                    ),
                  ],
                ),
                ShowTitle(
                  title: 'Address :',
                  textStyle: MyConstant().h2Style(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.75,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ShowTitle(
                          title: userMOdel!.address,
                          textStyle: MyConstant().h2Style(),
                        ),
                      ),
                    ),
                  ],
                ),
                ShowTitle(
                  title: 'Phone : ${userMOdel!.phone}',
                  textStyle: MyConstant().h2Style(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ShowTitle(
                    title: 'Avatar :',
                    textStyle: MyConstant().h2Style(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      width: constraints.maxWidth * 0.6,
                      child: CachedNetworkImage(
                        imageUrl: '${MyConstant.domain}${userMOdel!.avatar}',
                        placeholder: (context, url) => ShowProgress(),
                      ),
                    ),
                  ],
                ),
                ShowTitle(
                  title: 'Loacation :',
                  textStyle: MyConstant().h2Style(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: MyConstant.primary),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 16),
                      width: constraints.maxWidth * 0.6,
                      height: constraints.maxWidth * 0.6,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.parse(userMOdel!.lat),
                            double.parse(userMOdel!.lng),
                          ),
                          zoom: 16,
                        ),
                        markers: <Marker>[
                          Marker(
                            markerId: MarkerId('id'),
                            position: LatLng(
                              double.parse(userMOdel!.lat),
                              double.parse(userMOdel!.lng),
                            ),
                            infoWindow: InfoWindow(
                                title: userMOdel!.address,
                                snippet:
                                    'lat = ${userMOdel!.lat}, lng = ${userMOdel!.lng}'),
                          ),
                        ].toSet(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
