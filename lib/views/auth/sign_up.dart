import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoster/models/user_model.dart';
import 'package:hoster/utils/callbacks.dart';
import 'package:hoster/utils/shared.dart';
import 'package:icons_plus/icons_plus.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();

  bool _visibility = true;

  bool _gender = false;

  bool _role = false;

  bool _agree = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_fullNameController.text.trim().isEmpty) {
      showToast(context, "You must specify the full name");
    } else if (_emailController.text.trim().isEmpty) {
      showToast(context, "E-mail is required");
    } else if (_passwordController.text.trim().isEmpty) {
      showToast(context, "Password is mandatory");
    } else {
      final Response response = await Dio().post(
        "localhost/backend/register.php",
        data: <String, dynamic>{
          "name": _fullNameController.text.trim(),
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim(),
          "role": _role ? "Entreprise Client" : "Personal Client",
          "gender": _gender ? "M" : "F",
        },
      );
      if (response.data["status"] == true) {
        user = UserModel.fromJson(
          <String, dynamic>{
            "uid": response.data["result"],
            "name": _fullNameController.text.trim(),
            "email": _emailController.text.trim(),
            "password": _passwordController.text.trim(),
            "role": _role ? "Entreprise Client" : "Personal Client",
            "gender": _gender ? "M" : "F",
          },
        );
        // ignore: use_build_context_synchronously
        showToast(context, "User created successfully");
      } else {
        // ignore: use_build_context_synchronously
        showToast(context, "Something wrong", color: red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightWhite,
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        child: Container(
          width: MediaQuery.sizeOf(context).width * .6,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: dark,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: dark),
            boxShadow: <BoxShadow>[BoxShadow(color: dark.withOpacity(.5), blurStyle: BlurStyle.outer, offset: const Offset(7, 7))],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(FontAwesome.chevron_left_solid, size: 20, color: yellow)),
                    Text("Personal information", style: GoogleFonts.abel(color: lightWhite, fontSize: 35, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                Text("Name", style: GoogleFonts.abel(color: lightWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: dark.withOpacity(.2)),
                  child: TextField(
                    controller: _fullNameController,
                    style: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      border: InputBorder.none,
                      hintText: "Elon musk",
                      hintStyle: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text("E-mail", style: GoogleFonts.abel(color: lightWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: dark.withOpacity(.2)),
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: dark.withOpacity(.2)),
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
                Text("Additional information", style: GoogleFonts.abel(color: lightWhite, fontSize: 35, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text("Role", style: GoogleFonts.abel(color: lightWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) _) {
                    return AnimatedToggleSwitch<bool>.rolling(
                      height: 30,
                      current: _role,
                      indicatorSize: const Size.fromWidth(150),
                      values: const <bool>[false, true],
                      onChanged: (bool item) => _(() => _role = item),
                      iconList: <Widget>[
                        Text(
                          "Personal Client",
                          style: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Entreprise Client",
                          style: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                      style: ToggleStyle(
                        backgroundColor: dark.withOpacity(.1),
                        borderColor: lightWhite,
                        indicatorColor: yellow,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text("Gender", style: GoogleFonts.abel(color: lightWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) _) {
                    return AnimatedToggleSwitch<bool>.rolling(
                      height: 30,
                      current: _gender,
                      indicatorSize: const Size.fromWidth(150),
                      values: const <bool>[false, true],
                      onChanged: (bool item) => _(() => _gender = item),
                      iconList: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Bootstrap.gender_female, size: 15, color: lightWhite),
                            const SizedBox(width: 10),
                            Text(
                              "Female",
                              style: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Bootstrap.gender_male, size: 15, color: lightWhite),
                            const SizedBox(width: 10),
                            Text(
                              "Male",
                              style: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                      style: ToggleStyle(
                        backgroundColor: dark.withOpacity(.1),
                        borderColor: lightWhite,
                        indicatorColor: yellow,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) _) {
                        return Checkbox(
                          fillColor: const MaterialStatePropertyAll(transparent),
                          checkColor: yellow,
                          value: _agree,
                          onChanged: (bool? value) => _(() => _agree = value!),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text("I agree to the terms and conditions", style: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500))),
                  ],
                ),
                const SizedBox(height: 20),
                AnimatedButton(
                  width: 300,
                  text: 'Create account',
                  selectedTextColor: dark,
                  animatedOn: AnimatedOn.onHover,
                  backgroundColor: yellow,
                  borderRadius: 5,
                  isReverse: true,
                  selectedBackgroundColor: lightWhite,
                  transitionType: TransitionType.BOTTOM_TO_TOP,
                  textStyle: GoogleFonts.abel(color: dark, fontSize: 18, fontWeight: FontWeight.bold),
                  onPress: _signUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
