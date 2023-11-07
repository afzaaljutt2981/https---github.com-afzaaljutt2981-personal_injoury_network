import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/forgetPassword/view/verify_identity.dart';
import 'package:provider/provider.dart';

import '../controller/forget_password_controller.dart';

class CreateVerifyIdentityView extends StatefulWidget {
  CreateVerifyIdentityView(
      {super.key, required this.email, required this.from});

  String email;
  int from;

  @override
  State<CreateVerifyIdentityView> createState() =>
      _CreateVerifyIdentityViewState();
}

class _CreateVerifyIdentityViewState extends State<CreateVerifyIdentityView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgetPasswordController>(
        create: (_) => ForgetPasswordController(),
        child: VerifyIdentity(email: widget.email, from: widget.from));
  }
}
