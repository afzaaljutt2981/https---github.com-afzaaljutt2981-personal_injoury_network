
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/allRegisteredUsersController.dart';
import 'all_registered_users_view.dart';

class CreateAllRegisteredUsersView extends StatefulWidget {
  const CreateAllRegisteredUsersView({super.key});

  @override
  State<CreateAllRegisteredUsersView> createState() => _CreateAllRegisteredUsersViewState();
}

class _CreateAllRegisteredUsersViewState extends State<CreateAllRegisteredUsersView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllRegisteredUsersController>(
        create: (_) => AllRegisteredUsersController(), child: const AllRegisteredUsersScreen());
  }
}
