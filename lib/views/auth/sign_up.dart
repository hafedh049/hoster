import 'dart:convert';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoster/utils/callbacks.dart';
import 'package:hoster/utils/shared.dart';
import 'package:http/http.dart';
import 'package:hoster/views/client/holder.dart' as client;
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

  Future<void> _signUp() async {
    try {
      final Map<String, dynamic> data = <String, dynamic>{
        "email": _emailController.text,
        "password": _passwordController.text,
        "name": _fullNameController.text,
        "gender": _gender ? 'M' : 'F',
        "role": _role ? 'PERSONAL CLIENT' : 'ENTREPRISE CLIENT',
      };
      final Response response = await post(
        Uri.parse("http://localhost/backend/register.php"),
        headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded'},
        body: data,
      );
      if (response.statusCode == 200) {
        final dynamic id = jsonDecode(response.body)["result"];
        debugPrint("$data");
        if (data.isNotEmpty) {
          data.addAll(<String, dynamic>{'uid': id});
          // ignore: use_build_context_synchronously
          showToast(context, "Welcome");
          db!.put("login_state", true);
          db!.putAll(data);
          Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (BuildContext context) => const client.Holder()),
          );
        } else {
          // ignore: use_build_context_synchronously
          showToast(context, "User created successfully");
        }
      } else {
        // ignore: use_build_context_synchronously
        showToast(context, "Something went wrong");
        // Handle non-200 status codes (e.g., server errors)
        debugPrint("Error: ${response.statusCode}");
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showToast(context, e.toString(), color: red);
      // Handle any other errors, such as network errors
      debugPrint("Error: $e");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
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
