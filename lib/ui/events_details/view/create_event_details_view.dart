import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/create_event/models/event_model.dart';
import 'package:personal_injury_networking/ui/otherUserProfile/controller/other_user_profile_controller.dart';
import 'package:provider/provider.dart';

import '../controller/event_details_controller.dart';
import 'event_details_view.dart';

class CreateEventDetailsView extends StatefulWidget {
  CreateEventDetailsView({super.key, required this.event});

  EventModel? event;

  @override
  State<CreateEventDetailsView> createState() => _CreateEventDetailsViewState();
}

class _CreateEventDetailsViewState extends State<CreateEventDetailsView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventDetailsController>(
        create: (_) => EventDetailsController(widget.event?.id ?? ""),
        child: ChangeNotifierProvider(
          create: (_) => OtherUserProfileController(userId: widget.event?.uId),
          child: EventsDetailsView(
            event: widget.event,
          ),
        ));
  }
}
