import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/events/controller/events_controller.dart';
import 'package:provider/provider.dart';

import '../../chat_screen/model/chat_data.dart';
import 'home_screen.dart';

class CreateHomeScreenView extends StatefulWidget {
  CreateHomeScreenView({super.key, required this.messagesCallBack});

  Function(List<ChatData> chats) messagesCallBack;

  @override
  State<CreateHomeScreenView> createState() => _CreateHomeScreenViewState();
}

class _CreateHomeScreenViewState extends State<CreateHomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventsController>(
        create: (_) => EventsController(),
        child: HomeScreen(messagesCallBack: widget.messagesCallBack));
  }
}
