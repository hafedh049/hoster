import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hoster/utils/shared.dart';
import 'package:toastification/toastification.dart';

void showToast(BuildContext context, String message, {Color color = teal}) {
  toastification.show(
    context: context,
    title: Text("Notification",
        style: GoogleFonts.abel(
            fontSize: 18, fontWeight: FontWeight.w500, color: color)),
    description: Text(message,
        style: GoogleFonts.abel(
            fontSize: 16, fontWeight: FontWeight.w500, color: color)),
  );
}

void init() async {
  Hive.init(null);
  db = await Hive.openBox("db");
  if (db!.isEmpty) {
    db!.put("login_state", false);
  }
}
