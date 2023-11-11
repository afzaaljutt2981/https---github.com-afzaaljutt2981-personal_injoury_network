import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/chat_screen/controller/user_chat_data.dart';
import 'package:provider/provider.dart';

import 'all_users.dart';

class CreateChatView extends StatefulWidget {
  const CreateChatView({super.key});

  @override
  State<CreateChatView> createState() => _CreateChatViewState();
}

class _CreateChatViewState extends State<CreateChatView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserChatData>(
        create: (_) => UserChatData(), child: const AllUsersChat());
  }
}
