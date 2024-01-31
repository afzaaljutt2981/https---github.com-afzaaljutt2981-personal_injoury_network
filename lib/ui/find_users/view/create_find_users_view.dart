import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/find_users_controller.dart';
import 'find_users_view.dart';

class CreateFindUserView extends StatefulWidget {
  const CreateFindUserView({super.key});

  @override
  State<CreateFindUserView> createState() => _CreateFindUserViewState();
}

class _CreateFindUserViewState extends State<CreateFindUserView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FindUserController>(
        create: (_) => FindUserController(), child: const FindUser());
  }
}
