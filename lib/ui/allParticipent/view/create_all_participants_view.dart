import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/allParticipent/view/participants_view.dart';
import 'package:provider/provider.dart';

import '../../authentication/model/user_model.dart';
import '../controller/AllParticipantsController.dart';

class CreateAllParticipantsView extends StatefulWidget {
  CreateAllParticipantsView(
      {super.key, required this.users, required this.currentUser});
  List<UserModel> users;
  UserModel currentUser;
  @override
  State<CreateAllParticipantsView> createState() =>
      _CreateAllParticipantsViewState();
}

class _CreateAllParticipantsViewState extends State<CreateAllParticipantsView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllParticipantsController>(
        create: (_) => AllParticipantsController(),
        child: AllParticipantsView(
          users: widget.users,
          currentUser: widget.currentUser,
        ));
  }
}
