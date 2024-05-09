import 'dart:convert';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoster/models/language_model.dart';
import 'package:hoster/utils/callbacks.dart';
import 'package:hoster/views/auth/sign_in.dart';
import 'package:hoster/views/client/subscription.dart';
import 'package:http/http.dart';

import '../../utils/shared.dart';

class OurPlans extends StatefulWidget {
  const OurPlans({super.key});

  @override
  State<OurPlans> createState() => _OurPlansState();
}

class _OurPlansState extends State<OurPlans> {
  final List<SubsDuration> _list = List<SubsDuration>.generate(12, (int index) => SubsDuration((index + 1).toString()));
  final GlobalKey<State<StatefulWidget>> _seeSubsKey = GlobalKey<State<StatefulWidget>>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: lightWhite,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 80),
            Text("Choose your plan", style: GoogleFonts.abel(color: dark, fontSize: 35, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              runSpacing: 40,
              spacing: 40,
              children: <Widget>[
                for (final Map<String, dynamic> item in plans)
                  StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) _) {
                      return InkWell(
                        splashColor: transparent,
                        highlightColor: transparent,
                        hoverColor: transparent,
                        onHover: (bool value) => _(() => item['state'] = value),
                        onTap: () async {
                          setState(() {});
                          if (db!.get("login_state")) {
                            try {
                              final Response response = await post(
                                Uri.parse("http://localhost/backend/add_subscription.php"),
                                headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded'},
                                body: <String, dynamic>{
                                  "plan_duration": int.parse(item["duration"]),
                                  "plan_price": int.parse(item["price"].split(" ").first),
                                },
                              );

                              if (response.statusCode == 200) {
                                final dynamic data = jsonDecode(response.body)["result"];
                                debugPrint("$data");
                                if (data == "success") {
                                  // ignore: use_build_context_synchronously
                                  showToast(context, "Subscription plan has been added.");
                                  _seeSubsKey.currentState!.setState(() {});
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showToast(context, data, color: red);
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
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const SignIn()));
                          }
                        },
                        child: AnimatedScale(
                          duration: 300.ms,
                          scale: item['state'] ? 1.2 : 1,
                          child: Container(
                            width: 270,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: yellow),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(item["title"], style: GoogleFonts.abel(fontSize: 25, fontWeight: FontWeight.w500, color: dark)),
                                    const SizedBox(width: 10),
                                    Card(
                                      elevation: 6,
                                      shadowColor: dark,
                                      child: SizedBox(
                                        width: 100,
                                        height: 50,
                                        child: CustomDropdown<SubsDuration>.search(
                                          items: _list,
                                          excludeSelected: false,
                                          initialItem: _list.first,
                                          onChanged: (SubsDuration value) => item["duration"] = value.duration,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: <Widget>[
                                    Text(item["price"], style: GoogleFonts.abel(fontSize: 35, fontWeight: FontWeight.bold, color: dark)),
                                    const SizedBox(width: 10),
                                    Text(item["by"], style: GoogleFonts.abel(fontSize: 18, fontWeight: FontWeight.w500, color: dark)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                for (final String plan in item["plans"]) ...<Widget>[
                                  Text(plan, style: GoogleFonts.abel(fontSize: 18, fontWeight: FontWeight.w500, color: dark)),
                                  if (plan != item["plans"].last) const SizedBox(height: 10),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
            StatefulBuilder(
              key: _seeSubsKey,
              builder: (BuildContext context, void Function(void Function()) _) => db!.get("login_state")
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Center(
                          child: AnimatedButton(
                            width: 400,
                            text: 'See Subscriptions',
                            selectedTextColor: lightWhite,
                            animatedOn: AnimatedOn.onHover,
                            backgroundColor: teal,
                            borderRadius: 5,
                            isReverse: true,
                            selectedBackgroundColor: dark,
                            transitionType: TransitionType.BOTTOM_TO_TOP,
                            textStyle: GoogleFonts.abel(color: lightWhite, fontSize: 18, fontWeight: FontWeight.w500),
                            onPress: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Subscription())),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
