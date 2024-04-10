import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/shared.dart';

class OurPlans extends StatefulWidget {
  const OurPlans({super.key});

  @override
  State<OurPlans> createState() => _OurPlansState();
}

class _OurPlansState extends State<OurPlans> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: lightWhite,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 80),
            Text("Choose your plan", style: GoogleFonts.itim(color: dark, fontSize: 35, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              runSpacing: 40,
              spacing: 40,
              children: <Widget>[
                for (final Map<String, dynamic> item in plans)
                  StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) _) {
                      return InkWell(
                        splashColor: transparent,
                        highlightColor: transparent,
                        hoverColor: transparent,
                        onHover: (bool value) => _(() => item['state'] = value),
                        onTap: () {},
                        child: AnimatedScale(
                          duration: 300.ms,
                          scale: item['state'] ? 1.2 : 1,
                          child: Container(
                            width: 250,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: yellow),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(item["title"], style: GoogleFonts.itim(fontSize: 25, fontWeight: FontWeight.w500, color: dark)),
                                const SizedBox(height: 20),
                                Row(
                                  children: <Widget>[
                                    Text(item["price"], style: GoogleFonts.itim(fontSize: 35, fontWeight: FontWeight.bold, color: dark)),
                                    const SizedBox(width: 10),
                                    Text(item["by"], style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: dark)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                for (final String plan in item["plans"]) ...<Widget>[
                                  Text(plan, style: GoogleFonts.itim(fontSize: 18, fontWeight: FontWeight.w500, color: dark)),
                                  if (plan != item["plans"].last) const SizedBox(height: 10),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
