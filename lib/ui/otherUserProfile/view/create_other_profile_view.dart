
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/other_user_profile_controller.dart';
import 'other_user_view.dart';
class CreateOtherUserProfileView extends StatefulWidget {
  const CreateOtherUserProfileView({super.key});

  @override
  State<CreateOtherUserProfileView> createState() => _CreateOtherUserProfileViewState();
}

class _CreateOtherUserProfileViewState extends State<CreateOtherUserProfileView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OtherUserProfileController>(
        create: (_) => OtherUserProfileController(), child: const OtherUserProfileScreen());
  }
}
