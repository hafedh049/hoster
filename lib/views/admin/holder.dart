import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoster/utils/shared.dart';
import 'package:hoster/views/admin/dashboard.dart';
import 'package:hoster/views/admin/settings.dart';
import 'package:hoster/views/admin/users_list.dart';
import 'package:hoster/views/client/holder.dart' as client;

class Holder extends StatefulWidget {
  const Holder({super.key});

  @override
  State<Holder> createState() => _HolderState();
}

class _HolderState extends State<Holder> {
  final PageController _tabsController = PageController();

  late final List<Map<String, dynamic>> _tabs;

  @override
  void initState() {
    _tabs = <Map<String, dynamic>>[
      <String, dynamic>{
        "title": "DASHBOARD",
        "callback": () => _tabsController.jumpToPage(0),
        "state": false,
      },
      <String, dynamic>{
        "title": "USERS LIST",
        "callback": () => _tabsController.jumpToPage(1),
        "state": false,
      },
      <String, dynamic>{
        "title": "LOGOUT",
        "callback": () async {
          await db!.clear();
          await db!.put("login_state", false);
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const client.Holder()), (Route route) => false);
        },
        "state": false,
      },
    ];
    super.initState();
  }

  @override
  void dispose() {
    _tabsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightWhite,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome to the Admin Panel", style: GoogleFonts.abel(color: dark, fontSize: 55, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) _) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (int index = 0; index < _tabs.length; index += 1)
                      InkWell(
                        splashColor: transparent,
                        highlightColor: transparent,
                        hoverColor: transparent,
                        onHover: (bool value) => _(() => _tabs[index]["state"] = value),
                        onTap: _tabs[index]["callback"],
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            AnimatedContainer(
                              duration: 300.ms,
                              margin: index == _tabs.length - 1 ? null : const EdgeInsets.only(right: 20),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(color: _tabs[index]["state"] ? dark : yellow, borderRadius: BorderRadius.circular(5)),
                              child: AnimatedDefaultTextStyle(
                                duration: 300.ms,
                                style: GoogleFonts.abel(letterSpacing: 2, fontSize: 16, fontWeight: FontWeight.w500, color: _tabs[index]["state"] ? yellow : dark),
                                child: Text(_tabs[index]["title"]),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
            Expanded(
              child: PageView(
                controller: _tabsController,
                physics: const NeverScrollableScrollPhysics(),
                children: const <Widget>[Dashboard(), UsersList(), Settings()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
