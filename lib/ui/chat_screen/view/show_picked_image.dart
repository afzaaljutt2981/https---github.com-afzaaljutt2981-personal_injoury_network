import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/utils/custom_snackbar.dart';
import 'package:personal_injury_networking/global/utils/functions.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:provider/provider.dart';

import '../../../global/utils/app_colors.dart';
import '../controller/chat_controller.dart';

// ignore: must_be_immutable
class ShowPickedImage extends StatelessWidget {
  ShowPickedImage({super.key, required this.image, required this.chatUser});

  Uint8List image;
  UserModel chatUser;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: MemoryImage(image),
            fit: BoxFit.cover,
            height: height,
            width: width,
          ),
          Positioned(
            bottom: 15,
            left: 20,
            child: Text(
              chatUser.userName??"",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
            bottom: 15,
            right: 20,
            child: GestureDetector(
              onTap: () async {
                Functions.showLoaderDialog(context);
                try {
                  String url = await Functions.uploadPic(image, "chatImages");
                  // ignore: use_build_context_synchronously
                  await context
                      .read<ChatController>()
                      .sendMessage(chatUser.id??"", url, "image");
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  CustomSnackBar(false).showInSnackBar(e.toString(), context);
                }
              },
              child: Container(
                height: 40.sp,
                width: 40.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.kBlackColor.withOpacity(0.2),
                        offset: const Offset(0, 1.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                      )
                    ],
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFFAF48FF), Color(0xFF212E73)],
                    )),
                child: const Center(
                  child: Icon(Icons.send, color: Colors.white, size: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
