import 'dart:ui';

import 'package:animated_loading_border/animated_loading_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoster/utils/shared.dart';
import 'package:hoster/views/admin/holder.dart';
import 'package:hoster/views/auth/sign_up.dart';
import 'package:icons_plus/icons_plus.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _visibility = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightWhite,
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        alignment: Alignment.center,
        child: AnimatedLoadingBorder(
          trailingBorderColor: lightWhite,
          borderColor: lightWhite,
          borderWidth: 7,
          child: Container(
            width: MediaQuery.sizeOf(context).width * .5,
            height: MediaQuery.sizeOf(context).height * .6,
            padding: const EdgeInsets.all(24),
            color: dark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("You have and account? Sign in", style: GoogleFonts.abel(color: lightWhite, fontSize: 35, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                AnimatedButton(
                  width: 250,
                  text: 'Sign-Up',
                  selectedTextColor: dark,
                  animatedOn: AnimatedOn.onHover,
                  backgroundColor: yellow,
                  borderRadius: 5,
                  isReverse: true,
                  selectedBackgroundColor: teal,
                  transitionType: TransitionType.BOTTOM_TO_TOP,
                  textStyle: GoogleFonts.abel(color: dark, fontSize: 16, fontWeight: FontWeight.w500),
                  onPress: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const SignUp())),
                ),
                const SizedBox(height: 20),
                Text("E-mail", style: GoogleFonts.abel(color: lightWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: lightWhite.withOpacity(.2)),
                  child: TextField(
                    controller: _emailController,
                    style: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      border: InputBorder.none,
                      hintText: "abc@xyz.com",
                      hintStyle: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text("Password", style: GoogleFonts.abel(color: lightWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: lightWhite.withOpacity(.2)),
                  child: StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) _) {
                      return TextField(
                        obscureText: _visibility,
                        controller: _passwordController,
                        style: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          border: InputBorder.none,
                          hintText: "***********",
                          hintStyle: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                          suffixIcon: IconButton(onPressed: () => _(() => _visibility = !_visibility), icon: Icon(!_visibility ? FontAwesome.eye_solid : FontAwesome.eye_slash_solid, color: yellow, size: 15)),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedButton(
                  width: 250,
                  text: 'Sign-in',
                  selectedTextColor: dark,
                  animatedOn: AnimatedOn.onHover,
                  backgroundColor: yellow,
                  borderRadius: 5,
                  isReverse: true,
                  selectedBackgroundColor: teal,
                  transitionType: TransitionType.BOTTOM_TO_TOP,
                  textStyle: GoogleFonts.abel(color: dark, fontSize: 16, fontWeight: FontWeight.w500),
                  onPress: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Holder())),
                ),
                const SizedBox(height: 20),
                Flexible(child: Center(child: Image.asset("assets/images/home_providers.png"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
