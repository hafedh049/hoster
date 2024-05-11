import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emailjs/emailjs.dart';
import 'package:hoster/utils/callbacks.dart';
import 'package:hoster/utils/shared.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> sendMail() async {
    if (_nameController.text.trim().isEmpty) {
      showToast(context, "Name field is empty");
    } else if (_emailController.text.trim().isEmpty) {
      showToast(context, "E-mail field is empty");
    } else if (_subjectController.text.trim().isEmpty) {
      showToast(context, "Subject field is empty");
    } else if (_messageController.text.trim().isEmpty) {
      showToast(context, "Message field is empty");
    } else {
      final Map<String, String> templateParams = <String, String>{
        'user_name': _nameController.text.trim(),
        'user_email': _emailController.text.trim(),
        'user_subject': _emailController.text.trim(),
        "user_message": _messageController.text.trim(),
      };

      try {
        await EmailJS.send(
          'service_l3saemi',
          'template_if571r6',
          templateParams,
          const Options(
            publicKey: 'Q63Rs2gA9msOLDXPm',
            privateKey: '_oQ4U9Vqj0xKwbFeT_b-9',
          ),
        );
        // ignore: use_build_context_synchronously
        showToast(context, 'THE TECH SUPPORT WILL RESPOND AS SOON AS POSSIBLE!');
      } catch (error) {
        // ignore: use_build_context_synchronously
        showToast(context, error.toString());
      }
    }
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
            Text("Contact Us", style: GoogleFonts.abel(color: dark, fontSize: 35, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text("We'd love to hear from you! Feel free to reach out for any inquiries or assistance. Our team is ready to help.", style: GoogleFonts.abel(color: dark, fontSize: 25, fontWeight: FontWeight.w500)),
            const SizedBox(height: 40),
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: "Your name",
                    hintText: "Please fill this field.",
                    labelStyle: GoogleFonts.abel(color: dark, fontSize: 16, fontWeight: FontWeight.w500),
                    hintStyle: GoogleFonts.abel(color: dark, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: "E-mail",
                    hintText: "Enter you e-mail.",
                    labelStyle: GoogleFonts.abel(color: dark, fontSize: 16, fontWeight: FontWeight.w500),
                    hintStyle: GoogleFonts.abel(color: dark, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: TextField(
                  controller: _subjectController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: "Subject",
                    hintText: "What is the subject.",
                    labelStyle: GoogleFonts.abel(color: dark, fontSize: 16, fontWeight: FontWeight.w500),
                    hintStyle: GoogleFonts.abel(color: dark, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: TextField(
                  maxLines: 5,
                  controller: _messageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: "Message",
                    hintText: "Type something.",
                    labelStyle: GoogleFonts.abel(color: dark, fontSize: 16, fontWeight: FontWeight.w500),
                    hintStyle: GoogleFonts.abel(color: dark, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: AnimatedButton(
                width: 400,
                text: 'Send message',
                selectedTextColor: lightWhite,
                animatedOn: AnimatedOn.onHover,
                backgroundColor: teal,
                borderRadius: 5,
                isReverse: true,
                selectedBackgroundColor: dark,
                transitionType: TransitionType.BOTTOM_TO_TOP,
                textStyle: GoogleFonts.abel(color: lightWhite, fontSize: 18, fontWeight: FontWeight.w500),
                onPress: sendMail,
              ),
            ),
            const SizedBox(height: 20),
            Center(child: Text("Email: admin@web_hosting_master.com", style: GoogleFonts.abel(color: dark, fontSize: 20, fontWeight: FontWeight.w500))),
            const SizedBox(height: 20),
            Center(child: Text("Phone: +216-29-72-03-28", style: GoogleFonts.abel(color: dark, fontSize: 20, fontWeight: FontWeight.w500))),
          ],
        ),
      ),
    );
  }
}
