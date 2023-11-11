import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/auth_controller.dart';
import 'login_view.dart';

class CreateAuthenticationView extends StatefulWidget {
  const CreateAuthenticationView({super.key});

  @override
  State<CreateAuthenticationView> createState() =>
      _CreateAuthenticationViewState();
}

class _CreateAuthenticationViewState extends State<CreateAuthenticationView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthController>(
        create: (_) => AuthController(), child: const LoginView());
  }
}
