import 'package:flutter/cupertino.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/chat_screen/controller/chat_controller.dart';
import 'package:personal_injury_networking/ui/chat_screen/view/chat_view.dart';
import 'package:provider/provider.dart';

class SingleChatScreenView extends StatefulWidget {
  SingleChatScreenView({super.key, required this.user});

  UserModel user;

  @override
  State<SingleChatScreenView> createState() => _SingleChatScreenViewState();
}

class _SingleChatScreenViewState extends State<SingleChatScreenView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ChatController(otherUserId: widget.user.id),
        child: ChatScreen(user: widget.user));
  }
}
