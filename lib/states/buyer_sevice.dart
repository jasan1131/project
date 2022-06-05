import 'package:flutter/material.dart';
import 'package:flutter_myappication_1/bodys/buyer_menu_food.dart';
import 'package:flutter_myappication_1/bodys/buyer_product_type.dart';
import 'package:flutter_myappication_1/bodys/buyer_public_relation.dart';
import 'package:flutter_myappication_1/bodys/buyer_showallproduct.dart';
import 'package:flutter_myappication_1/bodys/buyer_special_product.dart';
import 'package:flutter_myappication_1/bodys/buyer_wholesale_product.dart';
import 'package:flutter_myappication_1/utility/my_constant.dart';
import 'package:flutter_myappication_1/widgets/show_signout.dart';
import 'package:flutter_myappication_1/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerService extends StatefulWidget {
  const BuyerService({Key? key}) : super(key: key);

  @override
  State<BuyerService> createState() => _BuyerServiceState();
}

class _BuyerServiceState extends State<BuyerService> {
  List<Widget> wigets = [
    BuyerShowAllProduct(),
    BuyerMenuFood(),
    BuyerProductType(),
    BuyerSpecialProduct(),
    BuyerWholeSaleProduct(),
    BuyerPublicRelation(),
  ];
  int indexWidget = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Buyer'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                buildHeader(),
                buyerShowAllProduct(),
                buyerMenuFood(),
                buyerProductType(),
                buyerSpecialProduct(),
                buyerWholeSaleProduct(),
                buyerPublicRelation()
              ],
            ),
            ShowSignOut(),
          ],
        ),
      ),
      body: wigets[indexWidget],
    );
  }

  ListTile buyerShowAllProduct() {
    return ListTile(
      leading: Icon(
        Icons.shop_outlined,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'สินค้าทั้งหมด',
        textStyle: MyConstant().h2Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile buyerMenuFood() {
    return ListTile(
      leading: Icon(
        Icons.restaurant_menu,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'เมนูอาหาร',
        textStyle: MyConstant().h2Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile buyerProductType() {
    return ListTile(
      leading: Icon(
        Icons.account_tree_outlined,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'ประเภทสินค้า',
        textStyle: MyConstant().h2Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile buyerSpecialProduct() {
    return ListTile(
      leading: Icon(
        Icons.discount_outlined,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'สินค้าราคาพิเศษ',
        textStyle: MyConstant().h2Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 3;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile buyerWholeSaleProduct() {
    return ListTile(
      leading: Icon(
        Icons.workspace_premium_outlined,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'สิค้าราคาส่ง',
        textStyle: MyConstant().h2Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 4;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile buyerPublicRelation() {
    return ListTile(
      leading: Icon(
        Icons.turned_in_not,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'ประชาสัมพันธ์',
        textStyle: MyConstant().h2Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 5;
          Navigator.pop(context);
        });
      },
    );
  }

  UserAccountsDrawerHeader buildHeader() {
    return UserAccountsDrawerHeader(
      accountName: null,
      accountEmail: null,
    );
  }
}
