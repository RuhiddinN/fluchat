import 'package:firebase_core/firebase_core.dart';
import 'package:fluchat/src/services/auth-services/auth_services.dart';
import 'package:fluchat/src/ui/pages/sign_in_up_page/sign_in_page.dart';
import 'package:fluchat/src/ui/pages/sign_in_up_page/sign_up_page.dart';
import 'package:fluchat/src/ui/pages/splash_page/splash_page.dart';
import 'package:fluchat/src/ui/pages/user_info_page/user_info_page.dart';
import 'package:flutter/material.dart';

import 'src/ui/pages/bottom_nav_bar/bottom_nav_bar.dart';
import 'src/ui/pages/chats_page/chats_page.dart';
import 'src/ui/pages/contact_page/contact_page.dart';
import 'src/ui/pages/more_page/more_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      routes: {
        SplashPage.id: (context) => const SplashPage(),
        SignInPage.id: (context) => const SignInPage(),
        SignUpPage.id: (context) => const SignUpPage(),
        UserInfoPage.id: (context) => const UserInfoPage(),
        BottomNavBarr.id: (context) => BottomNavBarr(initialIndex: 0),
        ContactPage.id: (context) => const ContactPage(),
        ChatsPage.id: (context) => const ChatsPage(),
        MorePage.id: (context) => const MorePage(),
      },
    );
  }
}

class CheckUser extends StatelessWidget {
  const CheckUser({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthServices().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Icon(
                Icons.error_outline_outlined,
                color: Colors.red,
              ),
            );
          } else {
            if (snapshot.data == null) {
              return const SplashPage();
            } else {
              return const UserInfoPage();
            }
          }
        });
  }
}
