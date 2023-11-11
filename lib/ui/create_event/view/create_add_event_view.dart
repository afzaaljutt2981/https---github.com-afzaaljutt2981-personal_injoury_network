import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/create_event_controller.dart';
import 'add_event_view.dart';

class CreateAddEventView extends StatefulWidget {
  const CreateAddEventView({super.key});

  @override
  State<CreateAddEventView> createState() => _CreateAddEventViewState();
}

class _CreateAddEventViewState extends State<CreateAddEventView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateEventController>(
        create: (_) => CreateEventController(), child: const AddEventView());
  }
}
