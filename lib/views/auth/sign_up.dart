import 'package:animated_loading_border/animated_loading_border.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:date_format/date_format.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
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

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool _visibility = true;

  bool _gender = false;

  String _areyoua = "Student";

  DateTime _birthdate = DateTime.now();

  bool _agree = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellow,
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(color: yellow, image: DecorationImage(image: AssetImage("assets/images/header.png"), fit: BoxFit.cover)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: AnimatedLoadingBorder(
            trailingBorderColor: lightWhite,
            borderColor: lightWhite,
            borderWidth: 5,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.sizeOf(context).width * .6,
                    padding: const EdgeInsets.all(24),
                    color: dark.withOpacity(.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(FontAwesome.chevron_left_solid, size: 20, color: yellow)),
                            Text("Personal infromation", style: GoogleFonts.abel(color: lightWhite, fontSize: 35, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text("First name", style: GoogleFonts.abel(color: lightWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: lightWhite.withOpacity(.2)),
                          child: TextField(
                            controller: _firstNameController,
                            style: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              border: InputBorder.none,
                              hintText: "Elon",
                              hintStyle: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text("Last name", style: GoogleFonts.abel(color: lightWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: lightWhite.withOpacity(.2)),
                          child: TextField(
                            controller: _lastNameController,
                            style: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              border: InputBorder.none,
                              hintText: "Musk",
                              hintStyle: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.sizeOf(context).width * .6,
                    padding: const EdgeInsets.all(24),
                    color: dark.withOpacity(.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Additional information", style: GoogleFonts.abel(color: lightWhite, fontSize: 35, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Text("Birthday", style: GoogleFonts.abel(color: lightWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) _) {
                            return InkWell(
                              highlightColor: transparent,
                              hoverColor: transparent,
                              splashColor: transparent,
                              onTap: () async {
                                _birthdate = await showDatePickerDialog(
                                      context: context,
                                      minDate: DateTime(2021, 1, 1),
                                      maxDate: DateTime(2023, 12, 31),
                                    ) ??
                                    DateTime.now();
                                _(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: lightWhite.withOpacity(.2)),
                                child: IgnorePointer(
                                  ignoring: true,
                                  child: TextField(
                                    readOnly: true,
                                    style: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(8),
                                      border: InputBorder.none,
                                      hintText: formatDate(_birthdate, const <String>[dd, '/', mm, '/', yyyy]),
                                      hintStyle: GoogleFonts.abel(color: lightWhite, fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
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
                              current: _gender,
                              values: const <bool>[false, true],
                              onChanged: (bool item) => _(() => _gender = item),
                              iconList: const <Widget>[Icon(Bootstrap.gender_female, size: 20, color: lightWhite), Icon(Bootstrap.gender_male, size: 20, color: lightWhite)],
                              style: ToggleStyle(backgroundColor: lightWhite.withOpacity(.1), borderColor: lightWhite, indicatorColor: yellow),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Text("Are you a ?", style: GoogleFonts.abel(color: lightWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) _) {
                            return AnimatedToggleSwitch<String>.rolling(
                              current: _areyoua,
                              values: const <String>["Student", "Professional"],
                              onChanged: (String item) => _(() => _areyoua = item),
                              iconBuilder: (String value, bool foreground) => Text(value, style: GoogleFonts.abel(color: lightWhite, fontSize: 14, fontWeight: FontWeight.w500)),
                              style: ToggleStyle(backgroundColor: lightWhite.withOpacity(.1), borderColor: lightWhite, indicatorColor: yellow),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) _) {
                                return Checkbox(value: _agree, onChanged: (bool? value) => _(() => _agree = value!));
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
                          backgroundColor: dark,
                          borderRadius: 5,
                          isReverse: true,
                          selectedBackgroundColor: lightWhite,
                          transitionType: TransitionType.BOTTOM_TO_TOP,
                          textStyle: GoogleFonts.itim(color: yellow, fontSize: 16, fontWeight: FontWeight.w500),
                          onPress: () {},
                        ),
                      ],
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
}
