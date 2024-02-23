import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';

class FaqScreen extends StatefulWidget {
  FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(8.sp),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                width: 100.sp,
                height: 40.sp,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: const Color(0xFF120D26),
                    size: 18.sp,
                  ),
                ),
              ),
            ),
          ),
          title: Center(
            child: Padding(
              padding: EdgeInsets.only(right: 45.w),
              child: Text(
                "Faq",
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        color: const Color(0xFF120D26),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            // FAQ(
            //   question: "Question 1",
            //   answer: data,
            //   ansDecoration: BoxDecoration(
            //       color: Colors.grey[500],
            //       borderRadius: const BorderRadius.all(Radius.circular(20))),
            //   queDecoration: BoxDecoration(
            //       color: Colors.grey[500],
            //       borderRadius: const BorderRadius.all(Radius.circular(20))),
            // ),
            createStyledFaq("Question 1", data),
            createStyledFaq("Question 1", data),

            // FAQ(
            //   question: "Question 3",
            //   answer: data,
            //   ansStyle: const TextStyle(color: Colors.blue, fontSize: 15),
            //   queStyle: const TextStyle(color: Colors.green, fontSize: 35),
            // ),
            // FAQ(
            //   question: "Question 4",
            //   answer: data,
            //   showDivider: false,
            // ),
            // FAQ(
            //   question: "Question 5",
            //   answer: data,
            //   expandedIcon: const Icon(Icons.minimize),
            //   collapsedIcon: const Icon(Icons.add),
            //   showDivider: false,
            //   ansStyle: const TextStyle(color: Colors.blue, fontSize: 15),
            //   ansPadding: const EdgeInsets.all(50),
            // ),
            // FAQ(
            //   question: "Question 6",
            //   answer: data,
            //   expandedIcon: const Icon(Icons.minimize),
            //   collapsedIcon: const Icon(Icons.add),
            //   ansStyle: const TextStyle(color: Colors.blue, fontSize: 15),
            //   ansPadding: const EdgeInsets.all(50),
            //   separator: Container(
            //     height: 5,
            //     width: double.infinity,
            //     color: Colors.purple,
            //   ),
            // ),
            // FAQ(
            //   question: "Question 7",
            //   answer: data,
            //   expandedIcon: const Icon(Icons.minimize),
            //   collapsedIcon: const Icon(Icons.add),
            //   showDivider: false,
            //   ansStyle: const TextStyle(color: Colors.blue, fontSize: 15),
            //   ansPadding: const EdgeInsets.all(50),
            // ),
          ]),
        ),
      ),
    );
  }

  String data = """
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
""";

  Widget createStyledFaq(String question, String answer) {
    return FAQ(
      question: question,
      answer: answer,
      ansPadding: EdgeInsets.all(15),
      showDivider: true,
      ansStyle: AppTextStyles.josefin(
          style: TextStyle(
              color: AppColors.kPrimaryColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600)),
      queStyle: AppTextStyles.josefin(
          style: TextStyle(
              color: AppColors.kPrimaryColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600)),
    );
  }
}
