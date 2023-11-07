
import 'package:fluchat/src/config/theme/app_colors.dart';
import 'package:fluchat/src/config/theme/font_theme.dart';
import 'package:fluchat/src/config/utils/app_route.dart';
import 'package:fluchat/src/config/utils/utils_app_loader.dart';
import 'package:fluchat/src/config/utils/utils_app_toast.dart';
import 'package:fluchat/src/services/auth-services/auth_services.dart';
import 'package:fluchat/src/ui/pages/sign_in_up_page/sign_up_page.dart';
import 'package:fluchat/src/ui/pages/user_info_page/user_info_page.dart';
import 'package:fluchat/src/ui/widgets/app_text_field.dart';
import 'package:fluchat/src/ui/widgets/buttons/app_main_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  static const String id = 'sign_in_page';

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscureText = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void sigIn() async {
    AuthServices authServices = AuthServices();
    final password = passwordController.text.trim();
    final email = emailController.text.trim();

    showLoader(context);
    authServices.signIn(email, password).then((value) {
      Go(context).close();

      if (value) {
        showToast(context: context, message: 'Login successful!');
        Go(context).id(UserInfoPage.id);
      } else {
        showToast(
            context: context,
            message:
                "Error: Email or Password entered incorrectly. Please check and try again!");
      }
    });
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            //Navigator.pushReplacementNamed(context, SignInPage.id);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 79, left: 40, right: 40),
              child: Text(
                "This App Entered",
                style: TextStyle(
                  fontFamily: 'mulish',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                height: 44,
                width: 327,
                decoration: const BoxDecoration(
                  color: Color(0xffF7F7FC),
                ),
                child: AppTextField(
                  hint: 'Enter Email',
                  controller: emailController,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18, left: 24, right: 24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                height: 44,
                width: 327,
                decoration: const BoxDecoration(
                  color: Color(0xffF7F7FC),
                ),
                child: TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscuringCharacter: "*",
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black87),
                      onPressed: _toggle,
                    ),
                    border: InputBorder.none,
                    hintText: 'Enter Password',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: mulish,
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            AppMainButton(
              title: 'Entered',
              onPressed: sigIn,
            ),
            const SizedBox(
              height: 40,
            ),
            RichText(
              text: TextSpan(
                text: "Do you have not  an accaunt?",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: mulish,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: "  Sign Up",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: mulish,
                      color: mainColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Go(context).id(SignUpPage.id);
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
