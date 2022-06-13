import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myappication_1/bodys/show_manage_admin.dart';
import 'package:flutter_myappication_1/bodys/show_order_admin.dart';
import 'package:flutter_myappication_1/bodys/show_productadmin.dart';
import 'package:flutter_myappication_1/models/user_models.dart';
import 'package:flutter_myappication_1/utility/my_constant.dart';
import 'package:flutter_myappication_1/widgets/show_progress.dart';
import 'package:flutter_myappication_1/widgets/show_signout.dart';
import 'package:flutter_myappication_1/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminServer extends StatefulWidget {
  const AdminServer({Key? key}) : super(key: key);

  @override
  State<AdminServer> createState() => _AdminServerState();
}

class _AdminServerState extends State<AdminServer> {
  List<Widget> widgets = [];
  int indexWidget = 0;
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUserModel();
  }

  Future<Null> findUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    print('### id Logined ==> $id');
    String apiGetUserWhereId =
        '${MyConstant.domain}/shopping/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(apiGetUserWhereId).then((value) {
      print('### value ==> $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
          print('### Name Logined ==> ${userModel!.name}');

          widgets.add(ShowOrderAdmin());
          widgets.add(ShowManageAdmin());
          widgets.add(ShowProductAdmin());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('admin'),
      ),
      drawer: widgets.length == 0
          ? SizedBox()
          : Drawer(
              child: Stack(
                children: [
                  ShowSignOut(),
                  Column(
                    children: [
                      buildHead(),
                      menuShowOrder(),
                      menuShopManage(),
                      menuProduct(),
                    ],
                  ),
                ],
              ),
            ),
      body: widgets.length == 0 ? ShowProgress() : widgets[indexWidget],
    );
  }

  UserAccountsDrawerHeader buildHead() {
    return UserAccountsDrawerHeader(
      otherAccountsPictures: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.edit),
          iconSize: 36,
          color: MyConstant.light,
          tooltip: 'Edit Shop',
        ),
      ],
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [MyConstant.light, MyConstant.dark],
          center: Alignment(-0.6, -0.2),
          radius: 1,
        ),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundImage:
            NetworkImage('${MyConstant.domain}${userModel!.avatar}'),
      ),
      accountName: Text(userModel == null ? 'Nmae' : userModel!.name),
      accountEmail: Text(userModel == null ? 'Typr ?' : userModel!.type),
    );
  }

  ListTile menuShowOrder() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
      leading: Icon(
        Icons.filter_1_outlined,
      ),
      title: ShowTitle(
        title: 'Show Order',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
          title: 'แสดงรายละเอียดของสินค้าทีลูกค้าสั่ง',
          textStyle: MyConstant().h3Style()),
    );
  }

  ListTile menuShopManage() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
      leading: Icon(
        Icons.filter_2_outlined,
      ),
      title: ShowTitle(
        title: 'Show ShopManage',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
          title: 'แสดงรายละเอียดของหน้าร้าน',
          textStyle: MyConstant().h3Style()),
    );
  }

  ListTile menuProduct() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
      leading: Icon(
        Icons.filter_3_outlined,
      ),
      title: ShowTitle(
        title: 'Show Product',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
          title: 'แสดงรายละเอียดของสินค้าที่ขาย',
          textStyle: MyConstant().h3Style()),
    );
  }
}
