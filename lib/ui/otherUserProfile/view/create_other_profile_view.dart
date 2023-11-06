import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../authentication/model/user_model.dart';
import '../controller/other_user_profile_controller.dart';
import 'other_user_view.dart';

class CreateOtherUserProfileView extends StatefulWidget {
  CreateOtherUserProfileView({super.key, required this.participant,required this.currentUser});
  UserModel participant;
  UserModel currentUser;
  @override
  State<CreateOtherUserProfileView> createState() =>
      _CreateOtherUserProfileViewState();
}

class _CreateOtherUserProfileViewState
    extends State<CreateOtherUserProfileView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
     create: (_)=>OtherUserProfileController(userId:widget.participant.id),
      child: OtherUserProfileScreen(
        currentUser: widget.currentUser,
      ),
    );
  }
}
