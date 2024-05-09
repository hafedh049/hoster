import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoster/utils/shared.dart';
import 'package:hoster/views/client/chat_room.dart';
import 'package:hoster/views/client/holder.dart';
import 'package:hoster/views/client/subscriptions_list.dart';
import 'package:icons_plus/icons_plus.dart';

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
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              margin: const EdgeInsets.all(24),
              width: 900,
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
                      Text(db!.get("name"), style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.w500, color: dark)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("E-mail: ", style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.bold, color: dark)),
                      const SizedBox(width: 5),
                      Text(db!.get("email"), style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.w500, color: dark)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Client Type: ", style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.bold, color: dark)),
                      const SizedBox(width: 5),
                      Text(db!.get("role"), style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.w500, color: dark)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text("Subscription History", style: GoogleFonts.abel(fontSize: 25, fontWeight: FontWeight.bold, color: dark)),
                  const SizedBox(height: 20),
                  const Flexible(child: SubscriptionsList()),
                  const SizedBox(height: 20),
                  Center(
                    child: AnimatedButton(
                      width: 400,
                      text: 'Open Chatroom',
                      selectedTextColor: lightWhite,
                      animatedOn: AnimatedOn.onHover,
                      backgroundColor: teal,
                      borderRadius: 5,
                      isReverse: true,
                      selectedBackgroundColor: dark,
                      transitionType: TransitionType.BOTTOM_TO_TOP,
                      textStyle: GoogleFonts.abel(color: lightWhite, fontSize: 18, fontWeight: FontWeight.w500),
                      onPress: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const SmartBot())),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: AnimatedButton(
                      width: 400,
                      text: 'Logout',
                      selectedTextColor: lightWhite,
                      animatedOn: AnimatedOn.onHover,
                      backgroundColor: teal,
                      borderRadius: 5,
                      isReverse: true,
                      selectedBackgroundColor: dark,
                      transitionType: TransitionType.BOTTOM_TO_TOP,
                      textStyle: GoogleFonts.abel(color: lightWhite, fontSize: 18, fontWeight: FontWeight.w500),
                      onPress: () async {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const Holder()), (Route route) => false);
                        await db!.clear();
                        await db!.put("login_state", false);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(FontAwesome.chevron_left_solid, color: yellow, size: 25),
            ),
          ),
        ],
      ),
    );
  }
}
