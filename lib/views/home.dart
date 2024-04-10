import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/shared.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(24),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          color: yellow,
          alignment: Alignment.center,
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            runSpacing: 30,
            spacing: 30,
            children: <Widget>[
              SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Your Web Hosting Partner", style: GoogleFonts.itim(color: dark, fontSize: 35, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Text("No contracts or unwanted fees. Get your Server up and running now!", style: GoogleFonts.itim(color: dark, fontSize: 25, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 20),
                    AnimatedButton(
                      width: 250,
                      text: 'Get Started Now!',
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
              Image.asset("assets/images/home_providers.png", width: 300, height: 300),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          color: lightWhite,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("What our customers say?", style: GoogleFonts.itim(color: dark, fontSize: 35, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                runSpacing: 30,
                spacing: 30,
                children: <Widget>[
                  for (final Map<String, dynamic> item in says)
                    StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) _) {
                        return InkWell(
                          splashColor: transparent,
                          highlightColor: transparent,
                          hoverColor: transparent,
                          onHover: (bool value) => _(() => item['state'] = value),
                          onTap: () {},
                          child: AnimatedContainer(
                            duration: 300.ms,
                            width: 300,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: item['state'] ? yellow : Colors.grey.withOpacity(.05),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(item["quote"], style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: dark)),
                                const SizedBox(height: 20),
                                Text(item["owner"], style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
