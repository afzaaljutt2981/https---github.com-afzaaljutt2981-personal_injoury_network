import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/myProfile/controller/my_profile_controller.dart';
import 'package:provider/provider.dart';

import 'faq_screen.dart';

class FaqScreenView extends StatefulWidget {
  FaqScreenView({super.key});

  @override
  State<FaqScreenView> createState() => _FaqScreenViewState();
}

class _FaqScreenViewState extends State<FaqScreenView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MyProfileController(), child: FaqScreen());
  }
}
