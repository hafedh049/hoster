import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoster/utils/shared.dart';
import 'package:icons_plus/icons_plus.dart';

class Holder extends StatefulWidget {
  const Holder({super.key});

  @override
  State<Holder> createState() => _HolderState();
}

class _HolderState extends State<Holder> {
  final List<Map<String, dynamic>> _tabs = <Map<String, dynamic>>[
    <String, dynamic>{
      "title": "DASHBOARD",
      "callback": () {},
      "state": false,
    },
    <String, dynamic>{
      "title": "USERS LIST",
      "callback": () {},
      "state": false,
    },
    <String, dynamic>{
      "title": "SETTINGS",
      "callback": () {},
      "state": false,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightWhite,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome to the Admin Panel", style: GoogleFonts.abel(color: dark, fontSize: 55, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) _) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (int index = 0; index < _tabs.length; index += 1)
                      InkWell(
                        splashColor: transparent,
                        highlightColor: transparent,
                        hoverColor: transparent,
                        onHover: (bool value) => _(() => _tabs[index]["state"] = value),
                        onTap: _tabs[index]["callback"],
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            AnimatedContainer(
                              duration: 300.ms,
                              margin: index == _tabs.length - 1 ? null : const EdgeInsets.only(right: 20),
                              padding: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _tabs[index]["state"] ? dark : transparent, width: 2))),
                              child: AnimatedDefaultTextStyle(
                                duration: 300.ms,
                                style: GoogleFonts.itim(letterSpacing: 2, fontSize: 16, fontWeight: FontWeight.w500, color: _tabs[index]["state"] ? dark : lightWhite),
                                child: Text(_tabs[index]["title"]),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
