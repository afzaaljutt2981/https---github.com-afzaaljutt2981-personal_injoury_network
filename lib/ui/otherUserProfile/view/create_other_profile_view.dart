import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../authentication/model/user_model.dart';
import '../controller/other_user_profile_controller.dart';
import 'other_user_view.dart';

class CreateOtherUserProfileView extends StatefulWidget {
  CreateOtherUserProfileView({super.key, required this.user});
  UserModel user;
  @override
  State<CreateOtherUserProfileView> createState() =>
      _CreateOtherUserProfileViewState();
}

class _CreateOtherUserProfileViewState
    extends State<CreateOtherUserProfileView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
     create: (_)=>OtherUserProfileController(userId:widget.user.id),
      child: OtherUserProfileScreen(
        user: widget.user,
      ),
    );
  }
}
