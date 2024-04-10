import 'package:flutter/material.dart';
import 'package:hoster/views/auth/sign_in.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Yassine Sahli's Blog",
      debugShowCheckedModeBanner: false,
      home: SignIn(),
    );
  }
}
