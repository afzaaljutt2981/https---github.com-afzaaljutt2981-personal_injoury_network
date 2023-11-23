import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/my_profile_controller.dart';
import 'my_profile.dart';

class CreateMyProfileView extends StatefulWidget {
  CreateMyProfileView({super.key, required this.from, required this.uid});

  String from;
  String uid;

  @override
  State<CreateMyProfileView> createState() => _CreateMyProfileViewState();
}

class _CreateMyProfileViewState extends State<CreateMyProfileView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MyProfileController(),
        child: MyProfileInfo(from: widget.from, uid: widget.uid));
  }
}
