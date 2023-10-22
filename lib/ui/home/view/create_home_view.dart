
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/home_screen_cotroller.dart';
import 'home_screen.dart';
class CreateHomeScreenView extends StatefulWidget {
  const CreateHomeScreenView({super.key});

  @override
  State<CreateHomeScreenView> createState() => _CreateHomeScreenViewState();
}

class _CreateHomeScreenViewState extends State<CreateHomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeScreenController>(
        create: (_) => HomeScreenController(), child: const HomeScreen());
  }
}
