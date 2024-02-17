import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:provider/provider.dart';

import '../controller/find_users_controller.dart';
import 'find_users_view.dart';

class CreateFindUserView extends StatefulWidget {
  CreateFindUserView({super.key, required this.user});

  UserModel? user;

  @override
  State<CreateFindUserView> createState() => _CreateFindUserViewState();
}

class _CreateFindUserViewState extends State<CreateFindUserView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FindUserController>(
        create: (_) => FindUserController(),
        child: FindUser(
          currentUser: widget.user,
        ));
  }
}
