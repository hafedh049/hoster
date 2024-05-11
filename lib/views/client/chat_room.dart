import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_loadingkit/flutter_animated_loadingkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hoster/models/message_model.dart';
import 'package:hoster/utils/api_keys.dart';
import 'package:hoster/utils/shared.dart';
import 'package:http/http.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:uuid/uuid.dart';

class SmartBot extends StatefulWidget {
  const SmartBot({super.key});

  @override
  State<SmartBot> createState() => _SmartBotState();
}

class _SmartBotState extends State<SmartBot> {
  List<MessageModel> _messages = <MessageModel>[];
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<State<StatefulWidget>> _messagesKey = GlobalKey<State<StatefulWidget>>();

  Future<void> _send() async {
    if (_messageController.text.trim().isNotEmpty) {
      final String message = _messageController.text.trim();
      _messages.add(MessageModel(uid: db!.get("uid"), id: const Uuid().v8(), message: message, timestamp: DateTime.now(), isYou: "Y"));
      _messages.add(MessageModel(uid: "-1", id: "-1", message: "", timestamp: DateTime.now(), isYou: "N"));
      _messagesKey.currentState!.setState(() {});
      await sendMessageToServer(_messages[_messages.length - 2]);
      _messageController.clear();
      final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
      final content = <Content>[Content.text(message)];
      final response = await model.generateContent(content);
      _messages.removeLast();
      _messages.add(MessageModel(uid: db!.get("uid"), id: const Uuid().v8(), message: response.text!, timestamp: DateTime.now(), isYou: "N"));
      await sendMessageToServer(_messages.last);
      _messagesKey.currentState!.setState(() {});
    }
  }

  Future<void> sendMessageToServer(MessageModel message) async {
    try {
      final Response response = await post(
        Uri.parse("http://localhost/backend/add_message.php"),
        headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded'},
        body: message.toJson(),
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Successful response
        debugPrint('Message sent successfully!');
        debugPrint('Response body: ${response.body}');
      } else {
        // Handle error
        debugPrint('Failed to send message. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or server errors
      debugPrint('Error sending message: $e');
    }
  }

  Future<List<MessageModel>> _fetchMessages() async {
    try {
      // Make GET request to the PHP script
      final Response response = await post(
        Uri.parse("http://localhost/backend/fetch_messages.php"),
        headers: const <String, String>{'Content-Type': 'application/x-www-form-urlencoded'},
        body: <String, dynamic>{"uid": db!.get("uid")},
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Successful response
        // Decode the JSON response body
        List<dynamic> jsonMessages = jsonDecode(response.body)["result"];
        // Convert JSON messages to MessageModel objects
        List<MessageModel> messages = jsonMessages.map((dynamic json) => MessageModel.fromJson(json)).toList().cast<MessageModel>()
          ..sort(
            (MessageModel a, MessageModel b) => a.timestamp.microsecondsSinceEpoch > b.timestamp.microsecondsSinceEpoch ? 1 : -1,
          );
        return messages;
      } else {
        // Handle error
        debugPrint('Failed to fetch messages. Status code: ${response.statusCode}');
        return <MessageModel>[];
      }
    } catch (e) {
      // Handle network or server errors
      debugPrint('Error fetching messages: $e');
      return <MessageModel>[];
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _messages.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightWhite,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<List<MessageModel>>(
          future: _fetchMessages(),
          builder: (BuildContext context, AsyncSnapshot<List<MessageModel>> snapshot) {
            if (snapshot.hasData) {
              _messages = snapshot.data!;
              return Column(
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
                    child: StatefulBuilder(
                      key: _messagesKey,
                      builder: (BuildContext context, void Function(void Function()) _) {
                        return ListView.separated(
                          reverse: false,
                          itemBuilder: (BuildContext context, int index) => _messages[index].id == "-1"
                              ? SizedBox(
                                  child: Card(
                                    color: lightWhite,
                                    elevation: 4,
                                    shadowColor: dark,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 30,
                                      margin: const EdgeInsets.symmetric(vertical: 10),
                                      padding: const EdgeInsets.all(16),
                                      child: const AnimatedLoadingSpiralLines(baseRadius: 5, color: dark, numberOfLines: 5, strokeWidth: 1),
                                    ),
                                  ),
                                )
                              : Messages(message: _messages[index], lastMessage: index == _messages.length - 1),
                          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
                          itemCount: _messages.length,
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            onEditingComplete: _send,
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
                          onPressed: _send,
                          icon: const Icon(FontAwesome.paper_plane_solid, color: dark, size: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: yellow));
            } else {
              return Center(child: Text("Something went wrong! ${snapshot.error}"));
            }
          },
        ),
      ),
    );
  }
}

class Messages extends StatefulWidget {
  const Messages({super.key, required this.message, required this.lastMessage});
  final MessageModel message;
  final bool lastMessage;
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  String formatDates(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference == 1) {
      return 'Yesterday ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference == 2) {
      return '2 days before ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 32,
      margin: widget.message.isYou == "Y" ? const EdgeInsets.only(left: 100) : const EdgeInsets.only(right: 100),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      constraints: BoxConstraints(maxWidth: (MediaQuery.sizeOf(context).width - 32) / 2),
      child: Card(
        elevation: 4,
        color: widget.message.isYou == "Y" ? yellow.withOpacity(.9) : lightWhite,
        shadowColor: dark,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: widget.lastMessage
                    ? AnimatedTextKit(
                        displayFullTextOnTap: true,
                        totalRepeatCount: 1,
                        animatedTexts: <AnimatedText>[TypewriterAnimatedText(widget.message.message, textStyle: GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.w500, color: dark))],
                      )
                    : Text(widget.message.message, style: GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.w500, color: dark)),
              ),
              const SizedBox(height: 10),
              Text(formatDates(widget.message.timestamp), style: GoogleFonts.abel(fontSize: 12, fontWeight: FontWeight.w500, color: dark)),
            ],
          ),
        ),
      ),
    );
  }
}
