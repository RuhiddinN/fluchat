import 'package:fluchat/src/ui/pages/sign_in_up_page/sign_up_page.dart';
import 'package:fluchat/src/ui/pages/splash_page/splash_page.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  static const String id = 'sign_in_page';

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscureText = true;

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
            Navigator.pushReplacementNamed(context, SplashPage.id);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff0F1828),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 79, left: 40, right: 40),
              child: Text(
                "Enter Your Email and Password",
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
                child: const TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Email',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'mulish',
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 24, right: 24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                height: 44,
                width: 327,
                decoration: const BoxDecoration(
                  color: Color(0xffF7F7FC),
                ),
                child: TextField(
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
                      fontFamily: 'mulish',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 36, right: 24),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, SignUpPage.id);
                    },
                    child: const Text(
                      "Sing Up",
                      style: TextStyle(
                          fontFamily: 'mulish',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xff002DE3)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, SignInPage.id);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 250),
          child: Container(
            height: 52,
            width: 327,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xff002DE3),
            ),
            child: const Center(
              child: Text(
                'Log In',
                style: TextStyle(
                  color: Color(0xffF7F7FC),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
