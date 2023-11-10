
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../authentication/model/user_model.dart';
import '../controller/allFriendsController.dart';
import 'all_friends_view.dart';

// ignore: must_be_immutable
class CreateAllFriendsView extends StatefulWidget {
   CreateAllFriendsView({super.key,required this.user});
UserModel user;
  @override
  State<CreateAllFriendsView> createState() => _CreateAllFriendsViewState();
}

class _CreateAllFriendsViewState extends State<CreateAllFriendsView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllFriendsController>(
        create: (_) => AllFriendsController(), child: AllFriendsScreen(user: widget.user,));
  }
}
