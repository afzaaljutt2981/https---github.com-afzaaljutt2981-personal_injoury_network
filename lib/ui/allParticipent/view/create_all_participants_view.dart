
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/allParticipent/view/participants_view.dart';
import 'package:provider/provider.dart';

import '../controller/AllParticipantsController.dart';


class CreateAllParticipantsView extends StatefulWidget {
  const CreateAllParticipantsView({super.key});

  @override
  State<CreateAllParticipantsView> createState() => _CreateAllParticipantsViewState();
}

class _CreateAllParticipantsViewState extends State<CreateAllParticipantsView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllParticipantsController>(
        create: (_) => AllParticipantsController(), child: const AllParticipantsView());
  }
}
