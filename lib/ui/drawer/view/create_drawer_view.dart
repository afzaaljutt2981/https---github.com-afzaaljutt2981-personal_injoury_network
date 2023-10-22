
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/drawer/view/drawer_home.dart';
import 'package:provider/provider.dart';
import '../controller/drawer_controller.dart';

class CreateDrawerView extends StatefulWidget {
  const CreateDrawerView({super.key});

  @override
  State<CreateDrawerView> createState() => _CreateDrawerViewState();
}

class _CreateDrawerViewState extends State<CreateDrawerView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyDrawerController>(
        create: (_) => MyDrawerController(), child: const MyDrawerHome());
  }
}
