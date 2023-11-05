import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/chat_controller.dart';
import 'all_users.dart';

class CreateChatView extends StatefulWidget {
  const CreateChatView({super.key});

  @override
  State<CreateChatView> createState() => _CreateChatViewState();
}

class _CreateChatViewState extends State<CreateChatView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatController>(
        create: (_) => ChatController(""), child: const AllUsersChat());
  }
}
