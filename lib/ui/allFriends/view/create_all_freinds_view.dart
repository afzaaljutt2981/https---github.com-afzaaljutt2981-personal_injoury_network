
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/allFriendsController.dart';
import 'all_friends_view.dart';

class CreateAllFriendsView extends StatefulWidget {
  const CreateAllFriendsView({super.key});

  @override
  State<CreateAllFriendsView> createState() => _CreateAllFriendsViewState();
}

class _CreateAllFriendsViewState extends State<CreateAllFriendsView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllFriendsController>(
        create: (_) => AllFriendsController(), child: const AllFriendsScreen());
  }
}
