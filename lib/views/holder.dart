import 'package:flutter/material.dart';
import 'package:hoster/views/about_us.dart';
import 'package:hoster/views/contact_us.dart';
import 'package:hoster/views/header.dart';
import 'package:hoster/views/home.dart';

import '../utils/shared.dart';
import 'our_plans.dart';

class Holder extends StatefulWidget {
  const Holder({super.key});

  @override
  State<Holder> createState() => _HolderState();
}

class _HolderState extends State<Holder> {
  final List<Widget> _screens = <Widget>[
    const Home(),
    const AboutUs(),
    const ContactUs(),
    const OurPlans(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: screensController,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => _screens[index],
            itemCount: _screens.length,
          ),
          const Header(),
        ],
      ),
    );
  }
}
