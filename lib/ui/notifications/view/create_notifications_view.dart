import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/notiffications_controller.dart';
import 'notification_view.dart';

class CreateNotificationsView extends StatefulWidget {
  const CreateNotificationsView({super.key});

  @override
  State<CreateNotificationsView> createState() =>
      _CreateNotificationsViewState();
}

class _CreateNotificationsViewState extends State<CreateNotificationsView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationsController>(
        create: (_) => NotificationsController(),
        child: const NotificationView());
  }
}
