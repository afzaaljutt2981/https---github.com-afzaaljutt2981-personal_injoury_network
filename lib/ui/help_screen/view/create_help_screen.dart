import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/help_controller.dart';
import 'help_screen.dart';

class HelpScreenView extends StatefulWidget {
  HelpScreenView({super.key});


  @override
  State<HelpScreenView> createState() => _HelpScreenViewState();
}

class _HelpScreenViewState extends State<HelpScreenView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => HelpController(),
        child: HelpScreen());
  }
}
