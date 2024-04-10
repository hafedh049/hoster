import 'package:flutter/material.dart';
import 'package:hoster/utils/shared.dart';

class Holder extends StatefulWidget {
  const Holder({super.key});

  @override
  State<Holder> createState() => _HolderState();
}

class _HolderState extends State<Holder> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: lightWhite,
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
