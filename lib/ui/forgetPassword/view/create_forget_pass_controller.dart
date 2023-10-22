
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/forget_password_controller.dart';
import 'forget_view.dart';
class CreateForgetPasswordView extends StatefulWidget {
  const CreateForgetPasswordView({super.key});

  @override
  State<CreateForgetPasswordView> createState() => _CreateForgetPasswordViewState();
}

class _CreateForgetPasswordViewState extends State<CreateForgetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgetPasswordController>(
        create: (_) => ForgetPasswordController(), child: const ForgetPasswordView());
  }
}
