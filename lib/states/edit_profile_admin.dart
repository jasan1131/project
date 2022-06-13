import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myappication_1/models/user_models.dart';
import 'package:flutter_myappication_1/utility/my_constant.dart';
import 'package:flutter_myappication_1/utility/my_dialog.dart';
import 'package:flutter_myappication_1/widgets/show_image.dart';
import 'package:flutter_myappication_1/widgets/show_progress.dart';
import 'package:flutter_myappication_1/widgets/show_title.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileAdmin extends StatefulWidget {
  const EditProfileAdmin({Key? key}) : super(key: key);

  @override
  State<EditProfileAdmin> createState() => _EditProfileAdminState();
}

class _EditProfileAdminState extends State<EditProfileAdmin> {
  UserModel? userModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  LatLng? latLng;
  final formKey = GlobalKey<FormState>();
  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    Position? position = await findPosition();
    if (position != null) {
      setState(() {
        latLng = LatLng(position.latitude, position.longitude);
        print('lat = ${latLng!.latitude}');
      });
    }
  }

  Future<Position?> findPosition() async {
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      position = null;
    }
    return position;
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user = preferences.getString('user')!;
    String apiGetUser =
        '${MyConstant.domain}/shopping/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(apiGetUser).then((value) {
      print('### value from APi ===> $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
          nameController.text = userModel!.name;
          addressController.text = userModel!.address;
          phoneController.text = userModel!.phone;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            onPressed: () => processEditProfileAdmin(),
            icon: Icon(Icons.edit),
            tooltip: 'Edit Profile Admin',
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(
            FocusNode(),
          ),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                buildTitle('Avatar :'),
                buildAvatar(constraints),
                buildTitle('General :'),
                buildName(constraints),
                buildAddress(constraints),
                buildPhone(constraints),
                buildTitle('Location :'),
                buildMap(constraints),
                buildButtonEdit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> processEditProfileAdmin() async {
    print('### ==>> processEditProfileAdmin Work');

    MyDialog().showProgressDialog(context);

    if (formKey.currentState!.validate()) {
      if (file == null) {
        print('## User Current Avatar');
        editValueToMySQL(userModel!.avatar);
      } else {
        String apiSaveAvatar = '${MyConstant.domain}/shopping/saveAvatar.php';

        List<String> nameAvatars = userModel!.avatar.split('/');
        String nameFile = nameAvatars[nameAvatars.length - 1];
        nameFile = 'edit${Random().nextInt(100)}$nameFile';

        print('## User New Avatar nameFile ==>> $nameFile');

        Map<String, dynamic> map = {};
        map['file'] =
            await MultipartFile.fromFile(file!.path, filename: nameFile);
        FormData formData = FormData.fromMap(map);
        await Dio().post(apiSaveAvatar, data: formData).then((value) {
          print('## Upload Success');
          String pathAvatar = '/shopping/avatar/$nameFile';
          editValueToMySQL(pathAvatar);
        });
      }
    }
  }

  Future<Null> editValueToMySQL(String pathAvatar) async {
    print('## pathAvatar ==>> $pathAvatar');
    String apiEditProfile =
        '${MyConstant.domain}/shopping/editProfileAdminWhereId.php?isAdd=true&id=${userModel!.id}&avatar=$pathAvatar&name=${nameController.text}&address=${addressController.text}&phone=${phoneController.text}&lat=${latLng!.latitude}&lng=${latLng!.longitude}';
    await Dio().get(apiEditProfile).then(
          (value) {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
  }

  ElevatedButton buildButtonEdit() {
    return ElevatedButton.icon(
      onPressed: () => processEditProfileAdmin(),
      icon: Icon(Icons.edit),
      label: Text('Edit Profile Admin'),
    );
  }

  Row buildMap(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: MyConstant.primary),
          ),
          margin: EdgeInsets.symmetric(vertical: 16),
          width: constraints.maxWidth * 0.6,
          height: constraints.maxWidth * 0.5,
          child: latLng == null
              ? ShowProgress()
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: latLng!,
                    zoom: 16,
                  ),
                  onMapCreated: (controller) {},
                  markers: <Marker>[
                    Marker(
                      markerId: MarkerId('id'),
                      position: latLng!,
                      infoWindow: InfoWindow(
                        title: userModel!.address,
                        snippet:
                            'lat = ${latLng!.latitude}, lng = ${latLng!.longitude}',
                      ),
                    ),
                  ].toSet(),
                ),
        ),
      ],
    );
  }

  Future<Null> createAvatar({ImageSource? source}) async {
    try {
      var result = await ImagePicker().getImage(
        source: source!,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row buildAvatar(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => createAvatar(source: ImageSource.camera),
              icon: Icon(
                Icons.add_a_photo,
                color: MyConstant.dark,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: MyConstant.primary),
              ),
              height: constraints.maxWidth * 0.6,
              width: constraints.maxWidth * 0.6,
              child: userModel == null
                  ? ShowProgress()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: userModel!.avatar == null
                          ? ShowImage(path: MyConstant.avatar)
                          : file == null
                              ? buildShowImageNetwork()
                              : Image.file(file!),
                    ),
            ),
            IconButton(
              onPressed: () => createAvatar(source: ImageSource.gallery),
              icon: Icon(
                Icons.add_photo_alternate,
                color: MyConstant.dark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  CachedNetworkImage buildShowImageNetwork() {
    return CachedNetworkImage(
      imageUrl: '${MyConstant.domain}${userModel!.avatar}',
      placeholder: (context, url) => ShowProgress(),
    );
  }

  Row buildName(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Name';
              } else {
                return null;
              }
            },
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Name :',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  
  Row buildAddress(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Address';
              } else {
                return null;
              }
            },
            maxLines: 5,
            controller: addressController,
            decoration: InputDecoration(
              hintText: 'Address :',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPhone(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill Phone';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.phone,
            controller: phoneController,
            decoration: InputDecoration(
              hintText: 'Phone :',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  ShowTitle buildTitle(String title) {
    return ShowTitle(
      title: title,
      textStyle: MyConstant().h2Style(),
    );
  }
}
