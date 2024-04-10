import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoster/utils/shared.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:video_player/video_player.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  late final VideoPlayerController _controller;

  bool _hoverVideo = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/video_about.mp4');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: lightWhite,
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * .9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80),
            Text("About Our Web Hosting Services", style: GoogleFonts.abel(color: dark, fontSize: 35, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text("Welcome to Web-Hosting-Master Hosting, your reliable web hosting partner. We are committed to providing top-notch hosting services tailored to your needs.", style: GoogleFonts.abel(color: dark, fontSize: 20, fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            Text("At Web-Hosting-Master Hosting, we believe in simplicity, performance, and excellent customer support. Whether you are a small business owner, developer, or an enterprise, we have the right hosting solutions for you.", style: GoogleFonts.abel(color: dark, fontSize: 20, fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            Text("Our mission is to empower your online presence by offering secure, scalable, and affordable hosting services. With state-of-the-art infrastructure and a team of experts, we ensure the stability and performance of your websites and applications.", style: GoogleFonts.abel(color: dark, fontSize: 20, fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<void>(
                future: _controller.initialize(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.hasData) {
                    _controller.setVolume(1);
                  }
                  return Center(
                    child: StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) _) {
                        return InkWell(
                          splashColor: transparent,
                          highlightColor: transparent,
                          hoverColor: transparent,
                          onTap: () async {
                            if (_controller.value.isPlaying) {
                              await _controller.pause();
                            } else {
                              await _controller.play();
                            }
                            _(() {});
                          },
                          onHover: (bool value) => _(() => _hoverVideo = value),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * .9,
                            height: _controller.value.size.height,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: dark),
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                VideoPlayer(_controller),
                                AnimatedOpacity(
                                  opacity: _hoverVideo ? 1 : 0,
                                  duration: 500.ms,
                                  child: Icon(
                                    _controller.value.isPlaying ? FontAwesome.circle_pause_solid : FontAwesome.circle_play_solid,
                                    size: 65,
                                    color: dark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
