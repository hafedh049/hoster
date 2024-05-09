import 'package:flutter/material.dart';
import 'package:hoster/utils/callbacks.dart';
import 'package:hoster/views/client/holder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Web Hosting",
      debugShowCheckedModeBanner: false,
      home: Holder(),
    );
  }
}
