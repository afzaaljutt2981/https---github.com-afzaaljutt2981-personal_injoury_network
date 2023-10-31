import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/authentication/controller/auth_controller.dart';
import 'package:provider/provider.dart';
import '../controller/my_profile_controller.dart';
import 'my_profile.dart';

class CreateMyProfileView extends StatefulWidget {
  const CreateMyProfileView({super.key});

  @override
  State<CreateMyProfileView> createState() => _CreateMyProfileViewState();
}

class _CreateMyProfileViewState extends State<CreateMyProfileView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MyProfileController(), child: const MyProfileInfo());
  }
}