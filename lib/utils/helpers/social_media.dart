import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../shared.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  final List<Map<String, dynamic>> _socials = <Map<String, dynamic>>[
    <String, dynamic>{
      "tooltip": "GITHUB",
      "icon": FontAwesome.github_brand,
      "callback": () {},
      "state": false,
    },
    <String, dynamic>{
      "tooltip": "INSTAGRAM",
      "icon": FontAwesome.instagram_brand,
      "callback": () {},
      "state": false,
    },
    <String, dynamic>{
      "tooltip": "X",
      "icon": FontAwesome.x_twitter_brand,
      "callback": () {},
      "state": false,
    },
    <String, dynamic>{
      "tooltip": "E-MAIL",
      "icon": FontAwesome.envelope_solid,
      "callback": () {},
      "state": false,
    },
    <String, dynamic>{
      "tooltip": "LINKEDIN",
      "icon": FontAwesome.linkedin_brand,
      "callback": () {},
      "state": false,
    },
    <String, dynamic>{
      "tooltip": "FACEBOOK",
      "icon": FontAwesome.facebook_brand,
      "callback": () {},
      "state": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(color: lightWhite.withOpacity(.2), borderRadius: BorderRadius.circular(10), border: Border.all(width: .5, color: lightWhite)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) _) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (int index = 0; index < _socials.length; index += 1)
                    Container(
                      margin: index != _socials.length - 1 ? const EdgeInsets.only(right: 30) : null,
                      child: Tooltip(
                        message: _socials[index]["tooltip"],
                        child: InkWell(
                          splashColor: transparent,
                          highlightColor: transparent,
                          hoverColor: transparent,
                          onHover: (bool value) => _(() => _socials[index]["state"] = value),
                          onTap: _socials[index]["callback"],
                          child: Icon(_socials[index]["icon"], color: _socials[index]["state"] ? teal : lightWhite, size: 35),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
