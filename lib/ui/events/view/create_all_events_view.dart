import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/events_controller.dart';
import 'all_events_screen.dart';

class CreateAllEventsView extends StatefulWidget {
  CreateAllEventsView({super.key, required this.from});

  String from = "";

  @override
  State<CreateAllEventsView> createState() => _CreateAllEventsViewState();
}

class _CreateAllEventsViewState extends State<CreateAllEventsView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventsController>(
        create: (_) => EventsController(),
        child: AllEventScreen(from: widget.from));
  }
}
