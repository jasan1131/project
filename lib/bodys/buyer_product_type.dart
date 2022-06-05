import 'package:flutter/material.dart';
import 'package:flutter_myappication_1/utility/my_constant.dart';
import 'package:flutter_myappication_1/widgets/show_title.dart';

class BuyerProductType extends StatefulWidget {
  const BuyerProductType({Key? key}) : super(key: key);

  @override
  State<BuyerProductType> createState() => _BuyerProductTypeState();
}

class _BuyerProductTypeState extends State<BuyerProductType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                child: Text('ประเภทสินค้า'),
              ),
            ],
          ),
          buildTypeNumPa(context),
          buildTypeNumCom(context),
        ],
      ),
    );
  }

  Column buildTypeNumCom(BuildContext context) {
    return Column(
          children: [
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, MyConstant.rounteTypeNumCom),
              child: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShowTitle(
                        title: 'น้ำส้ม',
                        textStyle: MyConstant().h2Style(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
  }

  Column buildTypeNumPa(BuildContext context) {
    return Column(
          children: [
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, MyConstant.rounteTypeNumPar),
              child: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShowTitle(
                        title: 'น้ำปลา',
                        textStyle: MyConstant().h2Style(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
  }
}
