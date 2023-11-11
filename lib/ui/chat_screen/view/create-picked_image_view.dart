import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/chat_screen/controller/chat_controller.dart';
import 'package:personal_injury_networking/ui/chat_screen/view/show_picked_image.dart';
import 'package:provider/provider.dart';

import '../../authentication/model/user_model.dart';

class CreatePickedImageView extends StatefulWidget {
  CreatePickedImageView(
      {super.key, required this.chatUser, required this.image});

  Uint8List image;
  UserModel chatUser;

  @override
  State<CreatePickedImageView> createState() => _CreatePickedImageViewState();
}

class _CreatePickedImageViewState extends State<CreatePickedImageView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ChatController(),
        child: ShowPickedImage(image: widget.image, chatUser: widget.chatUser));
  }
}
