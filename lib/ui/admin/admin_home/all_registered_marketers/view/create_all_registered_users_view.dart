
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/allRegisteredUsersMarketers.dart';
import 'all_registered_marketers_view.dart';

class CreateAllRegisteredMarketersView extends StatefulWidget {
  const CreateAllRegisteredMarketersView({super.key});

  @override
  State<CreateAllRegisteredMarketersView> createState() => _CreateAllRegisteredMarketersViewState();
}

class _CreateAllRegisteredMarketersViewState extends State<CreateAllRegisteredMarketersView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllRegisteredMarketersController>(
        create: (_) => AllRegisteredMarketersController(), child: const AllRegisteredMarketersScreen());
  }
}
