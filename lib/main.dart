import 'package:flutter/material.dart';
import 'package:flutter_myappication_1/states/add_product.dart';
import 'package:flutter_myappication_1/states/admin.dart';
import 'package:flutter_myappication_1/states/authen.dart';
import 'package:flutter_myappication_1/states/buyer_sevice.dart';
import 'package:flutter_myappication_1/states/create_account.dart';
import 'package:flutter_myappication_1/states/edit_profile_admin.dart';
import 'package:flutter_myappication_1/states/rider_service.dart';
import 'package:flutter_myappication_1/type/type_numcom.dart';
import 'package:flutter_myappication_1/type/type_numpar.dart';
import 'package:flutter_myappication_1/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/admin': (BuildContext context) => AdminServer(),
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/buyerService': (BuildContext context) => BuyerService(),
  '/riderService': (BuildContext context) => RiderService(),
  '/addProduct': (BuildContext context) => AddProduct(),
  '/editProfileAdmin': (BuildContext context) => EditProfileAdmin(),
  '/typenumpar' : (BuildContext context) => TypeNumPar(),
  '/typenumcom' :(BuildContext context) => TypeNumCom(),
};

String? initlalRoute;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? type = preferences.getString('type');
  print('## type ===>> $type');
  if (type?.isEmpty ?? true) {
    initlalRoute = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    switch (type) {
      case 'admin':
        initlalRoute = MyConstant.routeAdminSever;
        runApp(MyApp());
        break;
      case 'buyer':
        initlalRoute = MyConstant.routeBuyerService;
        runApp(MyApp());
        break;
      case 'rider':
        initlalRoute = MyConstant.routeRiderService;
        runApp(MyApp());
        break;
      default:
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor materialColor =
        MaterialColor(0xff2286c3, MyConstant.mapMaterialColor);
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoute,
      theme: ThemeData(primarySwatch: materialColor),
    );
  }
}
