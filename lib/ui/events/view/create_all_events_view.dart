import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/events_controller.dart';
import 'all_events_screen.dart';

class CreateAllEventsView extends StatefulWidget {
  const CreateAllEventsView({super.key});

  @override
  State<CreateAllEventsView> createState() => _CreateAllEventsViewState();
}

class _CreateAllEventsViewState extends State<CreateAllEventsView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventsController>(
        create: (_) => EventsController(), child: const AllEventScreen());
  }
}
