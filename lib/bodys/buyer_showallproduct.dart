import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myappication_1/models/product_model.dart';
import 'package:flutter_myappication_1/models/splite_model.dart';
import 'package:flutter_myappication_1/models/user_models.dart';
import 'package:flutter_myappication_1/utility/my_constant.dart';
import 'package:flutter_myappication_1/utility/sqlite_helpper.dart';
import 'package:flutter_myappication_1/widgets/show_image.dart';
import 'package:flutter_myappication_1/widgets/show_progress.dart';
import 'package:flutter_myappication_1/widgets/show_title.dart';

class BuyerShowAllProduct extends StatefulWidget {
  const BuyerShowAllProduct({Key? key}) : super(key: key);

  @override
  State<BuyerShowAllProduct> createState() => _BuyerShowAllProductState();
}

class _BuyerShowAllProductState extends State<BuyerShowAllProduct> {
  bool load = true;
  bool? haveData;
  List<ProductModel> productmodels = [];
  List<List<String>> listImages = [];
  int indexImage = 0;
  int amountInt = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readApiAllShop();
  }

  Future<Null> readApiAllShop() async {
    String urlAPI = '${MyConstant.domain}/shopping/getUserWhereAdmin.php';
    await Dio().get(urlAPI).then(
      (value) {
        setState(() {
          load = false;
          haveData = false;
        });
        // print('### value ==>> $value');
        var result = json.decode(value.data);
        // print('### result ==>> $result');
        for (var item in result) {
          // print('### item ==>> $item');
          ProductModel productModel = ProductModel.fromMap(item);

          String string = productModel.Images;
          string = string.substring(1, string.length - 1);
          List<String> strings = string.split(',');
          int i = 0;
          for (var item in strings) {
            strings[i] = item.trim();
            i++;
          }
          listImages.add(strings);

          // print('### name ==>> ${mOdel.name}');
          setState(() {
            load = false;
            haveData = true;
            productmodels.add(productModel);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return load
                ? ShowProgress()
                : haveData!
                    ? listProduct()
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ShowTitle(
                              title: 'NO DATA',
                              textStyle: MyConstant().h1Style(),
                            ),
                          ],
                        ),
                      );
          } else {
            return load
                ? ShowProgress()
                : haveData!
                    ? listProductHolizon()
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ShowTitle(
                              title: 'NO DATA',
                              textStyle: MyConstant().h1Style(),
                            ),
                          ],
                        ),
                      );
          }
        },
      ),
    );
  }

  Container listProduct() {
    return Container(
      child: GridView.builder(
        itemCount: productmodels.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          childAspectRatio: 2 / 4,
          maxCrossAxisExtent: 260,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            // print('### YOu Click Index ===>> $index');
            ShowAlertDialog(
              productmodels[index],
              listImages[index],
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: MyConstant.dark),
              borderRadius: BorderRadius.circular(16),
            ),
            shadowColor: MyConstant.dark,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyConstant.dark),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: MediaQuery.of(context).size.width * 0.4 - 8,
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: findUrlImage(productmodels[index].Images),
                        placeholder: (context, url) => ShowProgress(),
                        errorWidget: (context, url, error) =>
                            ShowImage(path: MyConstant.imageeror),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShowTitle(
                            title: productmodels[index].nameproduct,
                            textStyle: MyConstant().h2Style(),
                          ),
                          ShowTitle(
                            title:
                                'ราคา : ${productmodels[index].priceproduct} บาท',
                            textStyle: MyConstant().h3Style(),
                          ),
                          ShowTitle(
                            title: cutWord(
                                'รายระเอียดสินค้า : ${productmodels[index].productdetail}'),
                            textStyle: MyConstant().h3Style(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container listProductHolizon() {
    return Container(
      child: GridView.builder(
        itemCount: productmodels.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          childAspectRatio: 2 / 2,
          maxCrossAxisExtent: 400,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            // print('### YOu Click Index ===>> $index');
            ShowAlertDialog(
              productmodels[index],
              listImages[index],
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: MyConstant.dark),
              borderRadius: BorderRadius.circular(16),
            ),
            shadowColor: MyConstant.dark,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyConstant.dark),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: MediaQuery.of(context).size.width * 0.3 - 8,
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: findUrlImage(productmodels[index].Images),
                        placeholder: (context, url) => ShowProgress(),
                        errorWidget: (context, url, error) =>
                            ShowImage(path: MyConstant.imageeror),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShowTitle(
                            title: productmodels[index].nameproduct,
                            textStyle: MyConstant().h2Style(),
                          ),
                          ShowTitle(
                            title:
                                'ราคา : ${productmodels[index].priceproduct} บาท',
                            textStyle: MyConstant().h3Style(),
                          ),
                          ShowTitle(
                            title: cutWord(
                                'รายระเอียดสินค้า : ${productmodels[index].productdetail}'),
                            textStyle: MyConstant().h3Style(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String findUrlImage(String arrayImage) {
    String string = arrayImage.substring(1, arrayImage.length - 1);
    List<String> strings = string.split(',');
    int index = 0;
    for (var item in strings) {
      strings[index] = item.trim();
      index++;
    }
    String result = '${MyConstant.domain}/shopping${strings[0]}';
    // print('### result ===>> $result');
    return result;
  }

  Future<Null> ShowAlertDialog(
      ProductModel productmodel, List<String> images) async {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: ListTile(
            leading: ShowImage(path: MyConstant.image1),
            title: ShowTitle(
              title: productmodel.nameproduct,
              textStyle: MyConstant().h2Style(),
            ),
            subtitle: ShowTitle(
              title: 'ราคา ${productmodel.priceproduct} บาท',
              textStyle: MyConstant().h3Style(),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      '${MyConstant.domain}/shopping${images[indexImage]}',
                  placeholder: (context, url) => ShowProgress(),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(
                            () {
                              indexImage = 0;
                              print('### indexImage ==>> $indexImage');
                            },
                          );
                        },
                        icon: Icon(Icons.filter_1),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(
                            () {
                              indexImage = 1;
                              print('### indexImage ==>> $indexImage');
                            },
                          );
                        },
                        icon: Icon(Icons.filter_2),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(
                            () {
                              indexImage = 2;
                              print('### indexImage ==>> $indexImage');
                            },
                          );
                        },
                        icon: Icon(Icons.filter_3),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(
                            () {
                              indexImage = 3;
                              print('### indexImage ==>> $indexImage');
                            },
                          );
                        },
                        icon: Icon(Icons.filter_4),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    ShowTitle(
                      title: 'รายระเอียดสินค้า :',
                      textStyle: MyConstant().h2Style(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 200,
                        child: ShowTitle(
                          title: productmodel.productdetail,
                          textStyle: MyConstant().h3Style(),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (amountInt != 1) {
                          setState(() {
                            amountInt--;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: MyConstant.dark,
                      ),
                    ),
                    ShowTitle(
                      title: amountInt.toString(),
                      textStyle: MyConstant().h1Style(),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          amountInt++;
                        });
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: MyConstant.dark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () async {
                    String idProduct = productmodel.id;
                    String nameProduct = productmodel.nameproduct;
                    String priceProduct = productmodel.priceproduct;
                    String amount = amountInt.toString();
                    int sumInt = int.parse(priceProduct) * amountInt;
                    String sum = sumInt.toString();

                    print(
                        '### idSeller ==>> $idProduct, name ==>> $nameProduct, price ==>> $priceProduct, amount ==>> $amount, sum = $sum');
                    SQLiteModel sqLiteModel = SQLiteModel(
                        idProduct: idProduct,
                        nameProduct: nameProduct,
                        priceProduct: priceProduct,
                        amount: amount,
                        sum: sum);
                    await SQLiteHelpper().insertValueSQLite(sqLiteModel).then(
                      (value) {
                        amountInt = 1;
                        Navigator.pop(context);
                      },
                    );
                  },
                  child: ShowTitle(
                    title: 'Add',
                    textStyle: MyConstant().h2BlueStyle(),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: ShowTitle(
                    title: 'Cancel',
                    textStyle: MyConstant().h2RedStyle(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String cutWord(String string) {
    String result = string;
    if (result.length > 100) {
      result = result.substring(0, 100);
      result = '$result ... ';
    }
    return result;
  }
}
