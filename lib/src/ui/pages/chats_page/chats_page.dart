import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  static const String id = 'chats_page';

  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: Colors.red,
    );
  }
}
