import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_injury_networking/global/utils/functions.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/chat_screen/controller/chat_controller.dart';
import 'package:personal_injury_networking/ui/chat_screen/view/create-picked_image_view.dart';
import 'package:provider/provider.dart';
import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';
import 'package:record/record.dart';
import '../model/chat_model.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.user});
  UserModel user;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

TextEditingController textController = TextEditingController();
bool emplyList = false;

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> chats = [];
  Uint8List? image1;
  late AudioRecorder audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  String audioPath = "";
  bool pause = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioPlayer();
    audioRecord = AudioRecorder();
  }

  @override
  dispose() {
    super.dispose();
    audioRecord.dispose();
    audioPlayer.dispose();
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        isRecording = false;
        if (path != null) {
          audioPath = path;
        }
      });
      print("path is here $path");
    } catch (e) {
      print("Error in stop recording:$e");
    }
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        Directory directory = await getTemporaryDirectory();
        setState(() {
          isRecording = true;
        });
        await audioRecord.start(const RecordConfig(),
            path:
                "${directory.path}/${DateTime.now().millisecondsSinceEpoch.toString()}.mp3");
        print(isRecording);
        print("isRecording start");
      }
    } catch (e) {
      print("Error in start recording:$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Recording status");
    print(isRecording);
    chats = [];
    chats = context.watch<ChatController>().currentChat;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(17.sp),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          title: Row(
            children: [
              Text(
                widget.user.userName,
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: GestureDetector(
                onTap: () {},
                child: Image(
                  height: 22.sp,
                  width: 22.sp,
                  image: const AssetImage(
                      'assets/images/more_circle_create_event.png'),
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
            itemCount: chats.length,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              Alignment alignment = Alignment.topLeft;
              bool match = false;
              if (chats[index].senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                alignment = Alignment.topRight;
                match = true;
              }
              return Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 0, bottom: 10),
                  child: Align(
                    alignment: alignment,
                    child: (chats[index].messageType == "text")
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular((!match ? 0.sp : 20.sp)),
                                topRight:
                                    Radius.circular((match ? 0.sp : 20.sp)),
                                bottomLeft: Radius.circular(20.sp),
                                bottomRight: Radius.circular(20.sp),
                              ),
                              color: (!match
                                  ? const Color(0xFFF5F5F5)
                                  : AppColors.kPrimaryColor),
                            ),
                            padding: EdgeInsets.all(18.sp),
                            child: Text(
                              chats[index].messageContent,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: (!match ? Colors.black : Colors.white),
                              ),
                            ))
                        : (chats[index].messageType == "mp3")
                            ? IconButton(
                                onPressed: () async {
                                  await audioPlayer.play(
                                      UrlSource(
                                        chats[index].messageContent,
                                      ),
                                      mode: PlayerMode.mediaPlayer);
                                },
                                icon: const Icon(Icons.play_arrow))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image(
                                  image:
                                      NetworkImage(chats[index].messageContent),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                  ));
            },
          )),
          Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(
                    left: 5.w, bottom: 5.h, top: 5.h, right: 10.w),
                height: 60,
                color: Colors.white, // const
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200]!, //const Color(0xFFFAFAFA),
                          borderRadius: BorderRadius.circular(10.sp)),
                      height: 60,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 5.w,
                          ),
                          GestureDetector(
                            onTap: () async {
                              //  await emojiesPicker();
                            },
                            child: Image(
                              height: 22.sp,
                              width: 22.sp,
                              image: const AssetImage(
                                  'assets/images/emojie_chat_screen.png'),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          SizedBox(
                            width: 190.w,
                            child: TextField(
                              onChanged: (value) {
                                if (textController.text.isNotEmpty) {
                                  setState(() {
                                    emplyList = true;
                                  });
                                } else {
                                  setState(() {
                                    emplyList = false;
                                  });
                                }
                              },
                              controller: textController,
                              decoration: InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: AppTextStyles.josefin(
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12.sp),
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            width: emplyList ? 20.w : 0.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              _openAttachmentOptions();
                            },
                            child: Image(
                              height: 22.sp,
                              width: 22.sp,
                              image: const AssetImage(
                                  'assets/images/attachment_chat_screen.png'),
                            ),
                          ),
                          SizedBox(
                            width: emplyList ? 0.w : 15.w,
                          ),
                          emplyList == false
                              ? GestureDetector(
                                  onTap: () {
                                    pickImage(ImageSource.camera);
                                  },
                                  child: Image(
                                    height: 20.sp,
                                    width: 20.sp,
                                    image: const AssetImage(
                                        'assets/images/camera_chat_screen.png'),
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            width: 7.w,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onLongPress: () {
                        // if (!emplyList) {
                        //   startRecording();
                        //   showModalBottomSheet(
                        //     context: context,
                        //     builder: (context) {
                        //       return ChangeNotifierProvider(
                        //         create: (_) => ChatController(),
                        //         child: StatefulBuilder(
                        //           builder: (context,
                        //                   void Function(void Function())
                        //                       _setState) =>
                        //               SizedBox(
                        //             height: 100,
                        //             child: Center(
                        //                 child: Column(
                        //               // crossAxisAlignment:
                        //               //     CrossAxisAlignment.start,
                        //               children: [
                        //                 if (pause) ...[
                        //                   Row(
                        //                     children: [
                        //                       IconButton(
                        //                         onPressed: () {
                        //                           audioPlayer.play(
                        //                               UrlSource(audioPath));
                        //                         },
                        //                         icon: const Icon(
                        //                             Icons.play_arrow),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ] else ...[
                        //                   const Text("Recording............")
                        //                 ],
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     IconButton(
                        //                         onPressed: () {
                        //                           setState(() {
                        //                             audioRecord.stop();
                        //                             isRecording = false;
                        //                           });
                        //                           Navigator.pop(context);
                        //                         },
                        //                         icon: const Icon(Icons.delete)),
                        //                     InkWell(
                        //                         onTap: () async {
                        //                           setState(() {
                        //                             _setState(() {
                        //                               pause = !pause;
                        //                               if (pause) {
                        //                                 audioRecord.pause();
                        //                               } else {
                        //                                 audioRecord.resume();
                        //                               }
                        //                             });
                        //                           });
                        //                         },
                        //                         child: Icon((!pause)
                        //                             ? Icons.pause
                        //                             : Icons.mic)),
                        //                     IconButton(
                        //                         onPressed: () async {
                        //                           Functions.showLoaderDialog(
                        //                               context);
                        //                           await stopRecording();
                        //                           File file = File(audioPath);
                        //                           String url =
                        //                               await Functions.uploadPic(
                        //                                   file.readAsBytesSync(),
                        //                                   "voice",
                        //                                   contentType: "mp3");
                        //                           Provider.of<ChatController>(
                        //                                   context,
                        //                                   listen: false)
                        //                               .sendMessage(
                        //                                   widget.user.id,
                        //                                   url,
                        //                                   "mp3");
                        //                           Navigator.pop(context);
                        //                           Navigator.pop(context);
                        //                           print(url);
                        //                         },
                        //                         icon: const Icon(Icons.send))
                        //                   ],
                        //                 ),
                        //               ],
                        //             )),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   );
                        // }
                      },
                      onTap: () async {
                        if (emplyList) {
                          context.read<ChatController>().sendMessage(
                              widget.user.id, textController.text, "text");
                          setState(() {
                            textController.clear();
                            emplyList = false;
                          });
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
                        child:
                        // emplyList == false
                        //     ?const SizedBox()
                        // Padding(
                        //         padding: EdgeInsets.all(10.sp),
                        //         child: const Image(
                        //           image: AssetImage(
                        //               'assets/images/microphone_chat_screen.png'),
                        //         ),
                        //       )
                        //     :
                        const Center(
                                child: Icon(Icons.send,
                                    color: Colors.white, size: 20),
                              ),
                      ),
                    ),
                  ],
                ),
              ))
        ]));
  }

  pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      image1 = await pickedImage.readAsBytes();
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CreatePickedImageView(
                    image: image1!,
                    chatUser: widget.user,
                  )));
    }
  }

  // Future emojiesPicker() async {
  //   EmojiPicker(
  //     textEditingController: textController,
  //     config: Config(
  //       columns: 7,
  //       emojiSizeMax: 32 *
  //           (foundation.defaultTargetPlatform == TargetPlatform.iOS
  //               ? 1.30
  //               : 1.0),
  //       verticalSpacing: 0,
  //       horizontalSpacing: 0,
  //       gridPadding: EdgeInsets.zero,
  //       initCategory: Category.RECENT,
  //       bgColor: Color(0xFFF2F2F2),
  //       indicatorColor: Colors.blue,
  //       iconColor: Colors.grey,
  //       iconColorSelected: Colors.blue,
  //       backspaceColor: Colors.blue,
  //       skinToneDialogBgColor: Colors.white,
  //       skinToneIndicatorColor: Colors.grey,
  //       enableSkinTones: true,
  //       recentTabBehavior: RecentTabBehavior.RECENT,
  //       recentsLimit: 28,
  //       noRecents: const Text(
  //         'No Recents',
  //         style: TextStyle(fontSize: 20, color: Colors.black26),
  //         textAlign: TextAlign.center,
  //       ), // Needs to be const Widget
  //       loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
  //       tabIndicatorAnimDuration: kTabScrollDuration,
  //       categoryIcons: const CategoryIcons(),
  //       buttonMode: ButtonMode.MATERIAL,
  //     ),
  //   );
  // }
  void _openAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // Customize the appearance of your attachment options
          // Add buttons or widgets for different attachment options
          height: 200,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Choose Image'),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  pickImage(ImageSource
                      .gallery); // Method to pick an image (you may already have this method)
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_file),
                title: Text('Attach File'),
                onTap: () {
                  pickFile();
                  Navigator.pop(context);
                },
              ),
              // Add more ListTile widgets for different attachment options if needed
            ],
          ),
        );
      },
    );
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile file = result.files.first;
        print(file.runtimeType);
        print('Picked file path: ${file.path}');
      } else {
        // User canceled the picker
      }
    } catch (e) {
      // Handle exceptions that might occur during file picking
      print('Error picking file: $e');
    }
  }
}
