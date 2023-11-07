import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluchat/src/config/theme/app_colors.dart';
import 'package:fluchat/src/config/utils/app_id_generator.dart';
import 'package:fluchat/src/config/utils/app_route.dart';
import 'package:fluchat/src/config/utils/utils_app_loader.dart';
import 'package:fluchat/src/models/user_model.dart';
import 'package:fluchat/src/services/firebase_database/firebase_storage_services.dart';
import 'package:fluchat/src/services/real_db_services/real_db_services.dart';
import 'package:fluchat/src/ui/pages/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:fluchat/src/ui/widgets/app_text_field.dart';
import 'package:fluchat/src/ui/widgets/buttons/app_main_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoPage extends StatefulWidget {
  static const String id = 'user_info_page';

  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final imagePicker = ImagePicker();
  final name = TextEditingController();
  final surname = TextEditingController();
  final username = TextEditingController();
  final bio = TextEditingController();
  String photoUrl = "";
  String path = "";

  void pickImage() async {
    await imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        setState(() {
          path = value.path;
        });
      }
    });
  }

  void addToDatabase() async {
    showLoader(context);
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final userID = firebaseAuth.currentUser!.uid;
    RealDatabaseServices databaseServices = RealDatabaseServices();
    FirebaseStorageServices storageServices = FirebaseStorageServices();

    final imageUrl = await storageServices.upload(File(path));
    UserModel userModel = UserModel(
      id: userID,
      name: name.text.trim(),
      surname: surname.text.trim(),
      photoUrl: imageUrl ?? "",
      username: username.text.trim(),
      bio: bio.text.trim(),
      lastEnteredToApp: Token.now(),
      online: true,
    );
    databaseServices.add(userModel).then((value) {
      Go(context).close();
      Go(context).id(BottomNavBarr.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Your Profile',
          style: TextStyle(
            color: Color(0xff0F1828),
            fontWeight: FontWeight.w600,
            fontFamily: 'mulish',
            fontSize: 18,
            fontStyle: FontStyle.normal,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, BottomNavBarr.id);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff0F1828),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 64,
              ),
              Center(
                child: GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(color: mainColor),
                      image: path.isNotEmpty
                          ? DecorationImage(
                              image: FileImage(File(path)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: path.isEmpty
                        ? const Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 50,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              AppTextField(hint: 'Name', controller: name),
              const SizedBox(height: 32),
              AppTextField(hint: 'Surname', controller: surname),
              const SizedBox(height: 32),
              AppTextField(hint: "@Username", controller: username),
              const SizedBox(height: 32),
              AppTextField(hint: "Bio", controller: bio),
              const SizedBox(height: 40),
              AppMainButton(
                title: 'To place',
                onPressed: () {
                  addToDatabase();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
