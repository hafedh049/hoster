import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoster/utils/shared.dart';
import 'package:icons_plus/icons_plus.dart';

class SmartBot extends StatefulWidget {
  const SmartBot({super.key});

  @override
  State<SmartBot> createState() => _SmartBotState();
}

class _SmartBotState extends State<SmartBot> {
  final List<Map<String, dynamic>> _messages = <Map<String, dynamic>>[];
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightWhite,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(FontAwesome.chevron_left_solid, color: dark, size: 20),
                  tooltip: 'Go back',
                ),
                Text("Chatbot", style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.w500, color: dark)),
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) => Container(),
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
                itemCount: _messages.length,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: yellow,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.w500, color: dark),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                        hintText: "Prompt something",
                        hintStyle: GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.w500, color: dark),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(FontAwesome.paper_plane_solid, color: dark, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
