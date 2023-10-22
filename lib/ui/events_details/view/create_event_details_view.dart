
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/event_details_controller.dart';
import 'event_details_view.dart';
class CreateEventDetailsView extends StatefulWidget {
  const CreateEventDetailsView({super.key});

  @override
  State<CreateEventDetailsView> createState() => _CreateEventDetailsViewState();
}

class _CreateEventDetailsViewState extends State<CreateEventDetailsView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventDetailsController>(
        create: (_) => EventDetailsController(), child: const EventsDetailsView());
  }
}
