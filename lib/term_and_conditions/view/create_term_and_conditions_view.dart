import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/term_and_conditions_controller.dart';
import 'term_and_conditions.dart';

class CreateTermAndConditionsView extends StatefulWidget {
  const CreateTermAndConditionsView({super.key});

  @override
  State<CreateTermAndConditionsView> createState() =>
      _CreateTermAndConditionsViewState();
}

class _CreateTermAndConditionsViewState
    extends State<CreateTermAndConditionsView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TermAndConditionsController>(
        create: (_) => TermAndConditionsController(),
        child: const TermAndConditionsView());
  }
}
