import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:hoster/utils/shared.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final List<Map<String, dynamic>> _headers = <Map<String, dynamic>>[
    <String, dynamic>{
      "title": "HOME",
      "icon": FontAwesome.house_solid,
      "callback": () => screensController.jumpToPage(0),
      "state": false,
    },
    <String, dynamic>{
      "title": "ABOUT US",
      "icon": FontAwesome.box_archive_solid,
      "callback": () => screensController.jumpToPage(1),
      "state": false,
    },
    <String, dynamic>{
      "title": "CONTACT",
      "icon": FontAwesome.folder_solid,
      "callback": () => screensController.jumpToPage(2),
      "state": false,
    },
    <String, dynamic>{
      "title": "OUR PLANS",
      "icon": FontAwesome.user_solid,
      "callback": () => screensController.jumpToPage(3),
      "state": false,
    },
  ];

  bool _titleState = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        color: yellow,
        padding: const EdgeInsets.all(24),
        child: Row(
          children: <Widget>[
            StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) _) {
                return InkWell(
                  splashColor: transparent,
                  highlightColor: transparent,
                  hoverColor: transparent,
                  onHover: (bool value) => _(() => _titleState = value),
                  onTap: () {},
                  child: AnimatedDefaultTextStyle(
                    duration: 300.ms,
                    style: GoogleFonts.lato(
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1.5,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _titleState ? dark : lightWhite,
                    ),
                    child: const Text("Web Hosing Master"),
                  ),
                );
              },
            ),
            const Spacer(),
            StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) _) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (int index = 0; index < _headers.length; index += 1)
                      InkWell(
                        splashColor: transparent,
                        highlightColor: transparent,
                        hoverColor: transparent,
                        onHover: (bool value) => _(() => _headers[index]["state"] = value),
                        onTap: _headers[index]["callback"],
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            AnimatedContainer(
                              duration: 300.ms,
                              margin: index == _headers.length - 1 ? null : const EdgeInsets.only(right: 20),
                              padding: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _headers[index]["state"] ? dark : transparent, width: 2))),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(_headers[index]["icon"], color: _headers[index]["state"] ? dark : lightWhite, size: 15),
                                  const SizedBox(width: 10),
                                  AnimatedDefaultTextStyle(
                                    duration: 300.ms,
                                    style: GoogleFonts.abel(letterSpacing: 2, fontSize: 16, fontWeight: FontWeight.w500, color: _headers[index]["state"] ? dark : lightWhite),
                                    child: Text(_headers[index]["title"]),
                                  ),
                                ],
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
