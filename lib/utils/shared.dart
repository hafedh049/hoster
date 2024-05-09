import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hoster/models/user_model.dart';

const Color lightWhite = Colors.white;
const Color darkWhite = Color.fromARGB(255, 149, 149, 162);
const Color dark = Color.fromARGB(255, 27, 29, 30);
const Color red = Color.fromARGB(255, 245, 75, 75);
const Color teal = Color.fromARGB(255, 24, 124, 255);
const Color yellow = Color.fromARGB(255, 253, 204, 4);
const Color transparent = Colors.transparent;

final List<Map<String, dynamic>> says = <Map<String, dynamic>>[
  <String, dynamic>{
    "state": false,
    "quote":
        '"Web Hosting Master has transformed our online presence. The speed and reliability are unmatched!"',
    "owner": "John Doe, Founder of Tech Innovations",
  },
  <String, dynamic>{
    "state": false,
    "quote":
        "\"Exceptional service! Web Hosting Master's support team is always ready to assist, making our experience seamless.\"",
    "owner": "Jane Smith, CTO of Digital Solutions",
  },
  <String, dynamic>{
    "state": false,
    "quote":
        "\"Choosing Web Hosting Master was a game-changer for us. The features and performance exceeded our expectations\"",
    "owner": "Robert Johnson, Marketing Director at Global Ventures",
  },
];

final List<Map<String, dynamic>> plans = <Map<String, dynamic>>[
  <String, dynamic>{
    "state": false,
    "title": "Starter",
    "price": "19 TND",
    "by": "/month",
    "plans": const <String>[
      "1 Website",
      "10GB Disk Space",
      "Free Email Address",
      "Basic Web Builder",
      "No SSL Certificate",
      "Limited Support",
    ],
  },
  <String, dynamic>{
    "state": false,
    "title": "Advanced",
    "price": "49 TND",
    "by": "/month",
    "plans": const <String>[
      "5 Websites",
      "50GB Disk Space",
      "Free Email Address",
      "Basic Web Builder",
      "No SSL Certificate",
      "24/7 Chat Support",
    ],
  },
  <String, dynamic>{
    "state": false,
    "title": "Premium",
    "price": "99 TND",
    "by": "/month",
    "plans": const <String>[
      "50 Websites",
      "100GB Disk Space",
      "Free Email Address",
      "Basic Web Builder",
      "Free SSL Certificate",
      "24/7 Chat Support",
    ],
  },
];

int currentScreen = 0;

final PageController screensController =
    PageController(initialPage: currentScreen);

final GlobalKey<State<StatefulWidget>> pagerKey =
    GlobalKey<State<StatefulWidget>>();

UserModel? user;

Box? db;
