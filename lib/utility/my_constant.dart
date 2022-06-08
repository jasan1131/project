import 'package:flutter/material.dart';

class MyConstant {
  // Genernal
  static String appName = 'Shopping MAll';
  static String domain =
      'https://f62c-2001-fb1-1d-3eec-4f-1201-ed30-6588.ap.ngrok.io';

  // Route
  static String routeAdminSever = '/admin';
  static String routeAuthen = '/authen';
  static String routeCreasteAccount = '/createAccount';
  static String routeBuyerService = '/buyerService';
  static String routeRiderService = '/riderService';
  static String rounteAddProduct = '/addProduct';
  static String rounteEditProfileAdmin = '/editProfileAdmin';
  static String rounteTypeNumPar = '/typenumpar';
  static String rounteTypeNumCom = '/typenumcom';
  static String rounteShowCart = '/showcart';

  // Image
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String image3 = 'images/image3.png';
  static String image4 = 'images/image4.png';
  static String imageeror = 'images/eror.png';
  static String avatar = 'images/avatar.png';
  static String product = 'images/product.png';
  static String logofood = 'images/logofood.png';
  // color
  static Color primary = Color(0xff64b5f6);
  static Color dark = Color(0xff2286c3);
  static Color lighr = Color(0xff9be7ff);
  static Map<int, Color> mapMaterialColor = {
    50: Color.fromRGBO(255, 34, 134, 0.1),
    100: Color.fromRGBO(255, 34, 134, 0.2),
    200: Color.fromRGBO(255, 34, 134, 0.3),
    300: Color.fromRGBO(255, 34, 134, 0.4),
    400: Color.fromRGBO(255, 34, 134, 0.5),
    500: Color.fromRGBO(255, 34, 134, 0.6),
    600: Color.fromRGBO(255, 34, 134, 0.7),
    700: Color.fromRGBO(255, 34, 134, 0.8),
    800: Color.fromRGBO(255, 34, 134, 0.9),
    900: Color.fromRGBO(255, 34, 134, 1.0),
  };

  // Style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );
  TextStyle h1WhiteStyle() => TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.w800,
      );
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2WhiteStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2RedStyle() => TextStyle(
        fontSize: 18,
        color: Colors.red.shade800,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2BlueStyle() => TextStyle(
        fontSize: 18,
        color: Colors.blue.shade800,
        fontWeight: FontWeight.w700,
      );
  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );
  TextStyle h3WhiteStyle() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );

  // Button
  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
