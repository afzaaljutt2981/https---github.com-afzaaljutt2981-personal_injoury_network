
import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/events/controller/events_controller.dart';
import 'package:provider/provider.dart';

import 'admin_home_screen.dart';
class CreateAdminHomeScreenView extends StatefulWidget {
  const CreateAdminHomeScreenView({super.key});

  @override
  State<CreateAdminHomeScreenView> createState() => _CreateAdminHomeScreenViewState();
}

class _CreateAdminHomeScreenViewState extends State<CreateAdminHomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventsController>(
        create: (_) => EventsController(), child: const AdminHomeScreen());
  }
}
