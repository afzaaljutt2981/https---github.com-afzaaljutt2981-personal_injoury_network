import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/ui/chat_screen/model/chat_data.dart';

import '../../../global/utils/constants.dart';
import '../../admin/admin_home/admin_home_controller/view/admin_create_home_view.dart';
import '../../chat_screen/view/create_chat_view.dart';
import '../../events/view/create_all_events_view.dart';
import '../../myProfile/view/create_my_profile.dart';
import '../../qr_scan_screen/view/create_qr_scan_view.dart';
import 'create_home_view.dart';

// ignore: must_be_immutable
class BottomNavigationScreen extends StatefulWidget {
  BottomNavigationScreen({required this.selectedIndex, super.key});

  int selectedIndex;

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  PageController? _pageController;
  int? selectedIndex;
  List<ChatData> allChats = [];
  int unreadChats = 0;
  CollectionReference messagesRef =
      FirebaseFirestore.instance.collection("messages");
  List<ChatData> allMessages = [];
  StreamSubscription<QuerySnapshot<Object?>>? messagesStream;

  late Function stateChange;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
    _pageController = PageController(initialPage: selectedIndex!);

    messagesStream = messagesRef
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("chats")
        .snapshots()
        .listen((messages) {
      allMessages = [];
      for (var element in messages.docs) {
        allMessages
            .add(ChatData.fromJson(element.data() as Map<String, dynamic>));
      }
      unreadChats = allMessages
          .where((element) => element?.isRead == false)
          .toList()
          .length;
      stateChange.call();
    });
  }

  @override
  void dispose() {
    _pageController!.dispose();
    messagesStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
        _pageController!.animateToPage(index,
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      });
    }

    stateChange = () {
      print("set state called");
      setState(() {});
    };

    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => selectedIndex = index);
            },
            children: <Widget>[
              FirebaseAuth.instance.currentUser?.email?.toLowerCase() ==
                      Constants.adminEmail.toLowerCase()
                  ? const CreateAdminHomeScreenView()
                  : CreateHomeScreenView(
                      // messagesCallBack: (List<ChatData> chats) {
                      //   print("chats -> $chats");
                      //   if (chats
                      //           .where((element) => element?.isRead == false)
                      //           .toList()
                      //           .length !=
                      //       allChats
                      //           .where((element) => element?.isRead == false)
                      //           .toList()
                      //           .length) {
                      //     Future.delayed(Duration.zero, () async {
                      //       setState(() {
                      //         allChats = chats;
                      //         unreadChats = allChats
                      //             .where((element) => element?.isRead == false)
                      //             .toList()
                      //             .length;
                      //       });
                      //     });
                      //   }
                      // },
                      ),
              if (FirebaseAuth.instance.currentUser?.email?.toLowerCase() !=
                  Constants.adminEmail.toLowerCase())
                const CreateChatView(),
              CreateQrScanView(from: "2"),
              CreateAllEventsView(from: "2"),
              CreateMyProfileView(
                from: "2",
                uid: "",
              )
            ],
          ),
        ), //widgets[selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.sp),
                topLeft: Radius.circular(20.sp)),
            boxShadow: const [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          height: Platform.isIOS ? null : 65.h,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.sp),
              topRight: Radius.circular(20.sp),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: GoogleFonts.poppins(
                  color: AppColors.kPrimaryColor, fontSize: 12.sp),
              showUnselectedLabels: true,
              elevation: 2,
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: ImageIcon(
                      AssetImage('assets/images/home_icon_home_b.png')),
                  label: "Home",
                ),
                if (FirebaseAuth.instance.currentUser?.email?.toLowerCase() !=
                    Constants.adminEmail.toLowerCase())
                  BottomNavigationBarItem(
                    icon: Stack(children: [
                      if (unreadChats != 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Container(
                            width: 20.0, // Diameter of the circle
                            height: 20.0, // Diameter of the circle
                            decoration: const BoxDecoration(
                              color: AppColors.redColor, // Circle color
                              shape: BoxShape
                                  .circle, // Makes the container a circle
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  unreadChats.toString(), // The counting number
                                  style: const TextStyle(
                                    color: Colors.white, // Number color
                                    fontSize:
                                        15, // Adjust the size of the number
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      const ImageIcon(
                          AssetImage('assets/images/chat_icon_home_b.png')),
                    ]),
                    label: "Messages",
                  ),
                const BottomNavigationBarItem(
                  icon:
                      ImageIcon(AssetImage('assets/images/qr_icon_home_b.png')),
                  label: "QR Scan",
                ),
                const BottomNavigationBarItem(
                  icon: ImageIcon(
                      AssetImage('assets/images/events_icon_home_b.png')),
                  label: "Events",
                ),
                const BottomNavigationBarItem(
                  icon: ImageIcon(
                      AssetImage('assets/images/person_icon_home_b.png')),
                  label: "Profile",
                ),
              ],
              selectedItemColor: AppColors.kPrimaryColor,
              unselectedItemColor: AppColors.kBlackColor,
              currentIndex: selectedIndex!,
              onTap: onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
