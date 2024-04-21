import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoster/utils/shared.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightWhite,
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(child: Text("Welcome to subscription space", style: GoogleFonts.abel(fontSize: 35, fontWeight: FontWeight.bold, color: dark))),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Name: ", style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.bold, color: dark)),
                  const SizedBox(width: 5),
                  Text("Bishop", style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.w500, color: dark)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("E-mail: ", style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.bold, color: dark)),
                  const SizedBox(width: 5),
                  Text("pawn@gmail.com", style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.w500, color: dark)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Client Type: ", style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.bold, color: dark)),
                  const SizedBox(width: 5),
                  Text("Personal Client", style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.w500, color: dark)),
                ],
              ),
              const SizedBox(height: 20),
              Text("Subscription History", style: GoogleFonts.abel(fontSize: 25, fontWeight: FontWeight.bold, color: dark)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
