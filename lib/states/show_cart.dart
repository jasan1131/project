import 'package:flutter/material.dart';
import 'package:flutter_myappication_1/models/splite_model.dart';
import 'package:flutter_myappication_1/utility/my_constant.dart';
import 'package:flutter_myappication_1/utility/sqlite_helpper.dart';
import 'package:flutter_myappication_1/widgets/show_progress.dart';
import 'package:flutter_myappication_1/widgets/show_title.dart';

class ShowCart extends StatefulWidget {
  const ShowCart({Key? key}) : super(key: key);

  @override
  State<ShowCart> createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<SQLiteModel> sqliteModels = [];
  bool load = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processReadSQLite();
  }

  Future<Null> processReadSQLite() async {
    await SQLiteHelpper().readSQLite().then((value) {
      // print('### value on processReadSQlite ==>> $value');
      setState(() {
        load = false;
        sqliteModels = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Show Cart'),
      ),
      body: load
          ? ShowProgress()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ShowTitle(
                    title: 'รายการสินค้าที่สั่ง',
                    textStyle: MyConstant().h1Style(),
                  ),
                ),
                buildHead(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: sqliteModels.length,
                  itemBuilder: (context, index) => Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ShowTitle(
                          title: sqliteModels[index].nameProduct,
                          textStyle: MyConstant().h3Style(),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ShowTitle(
                          title: sqliteModels[index].priceProduct,
                          textStyle: MyConstant().h3Style(),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ShowTitle(
                          title: sqliteModels[index].amount,
                          textStyle: MyConstant().h3Style(),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ShowTitle(
                          title: sqliteModels[index].sum,
                          textStyle: MyConstant().h3Style(),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.red.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Container buildHead() {
    return Container(
      decoration: BoxDecoration(color: MyConstant.lighr),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ShowTitle(
                title: 'สินค้า',
                textStyle: MyConstant().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'ราคา',
                textStyle: MyConstant().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'จำนวน',
                textStyle: MyConstant().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'รวม',
                textStyle: MyConstant().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
