import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';

import '../../drawer/view/faq_new.dart';

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
                "FAQ",
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
            createStyledFaq(
                "What should I do when I cannot scroll down to the next line? ",
                "If you are having trouble scrolling down, just press the Next or Done key on your keyboard to move to the next line.",
                "Question1A",
                ""),
            createStyledFaq(
                "Why is it necessary to list three hobbies?",
                "Listing three hobbies helps people know more about you. When you share different hobbies, it gives a better idea of what you like and who you are. Having more hobbies can make it easier for others to connect with you over shared interests and start conversations.Scroll down from the list of hobbies and select the ones that match your interests the most.",
                "Question2A",
                ""),
            createStyledFaq("What should I do if I did not receive an email? ", "If you didn't get an email, first, look in your spam folder. If it is not there, try clicking Send email again, and you should get it soon. If you still don't get it, email us at PINetworking@gmail.com. Your inquiry will be resolved soon! ", "", ""),
            createStyledFaq("What is the home page for?","The home page is where you'll find all the published events. You can search for a specific event using the search bar, or you can just scroll down to see the list of events. Click on the View Event button to see more details about any event you are interested in.","Question4A",""),
            createStyledFaq("How can I register for an event? ","From the home page, click on the View Event to view event details. On the Event Details page,Just click Register to get registered for the event.  ","Question5A",""),
            createStyledFaq("Can I see who will attend the Event?","Yes, you can! All the people who clicked Register will show up at the bottom of the Event Details page.","Question6A",""),
            createStyledFaq("Can I engage with the participants of the event and send them private messages?","Yes you can. Simply add them as friends and start a conversation with them. ","",""),
            createStyledFaq("How do I send private messages? ","To send private messages, you need to send a friend request by clicking on Follow. Once the person receives and accepts your friend request, you both will be able to send private messages to each other.","Question8A","Question8B"),
            createStyledFaq("Where can I find the Menu? ","You can find the Menu either on the left side of the screen  by clicking the hamburger icon or at the bottom of the screen.","Question9A",""),
            createStyledFaq("What is the “Become a Marketer” section for? ","This section is for event organizers who want to promote their events to our users on the application. ","",""),
            createStyledFaq("If I click on \"Become a Marketer,\" will my profile change?","Yes, it will. You will only see your own events and not the ones published by others. If you “Become a Marketer” we recommend creating a new profile as a regular user if you want to see other events again.","",""),
            createStyledFaq("What is the “Events” section  for? ","This section is where you can see all the events you are, were or will be as a participant. ","",""),
            createStyledFaq("What does the “Messages” section do? ","This is where you can see all the messages you were involved in. ","",""),
            createStyledFaq("What is the “Friends” section for? ","The Friends section is where you will see all your network of friends. ","",""),
            createStyledFaq("Can I find other people on the application? ","Yes, you can use filters on the county and job position to search for friends. You can select multiple counties and multiple jobs from the dropdown menus.","Question15A",""),
            createStyledFaq("Can I know how many people I can reach?","Just do a quick search, and you will see the number of people you can target next to the View icon. Click on View, and you will see the list of people you can reach.","Question16A",""),
            createStyledFaq("How many counties and positions/jobs can I select? ","You can select one, multiple or even All to search for friends on the application. ","",""),
            createStyledFaq("Where can I find my QR code? ","You can see the QR Scan option at the bottom side on the screen. ","Question18A","Question18B"),
            createStyledFaq("Why do you need a QR code?","You need a QR code so that when you arrive at an event, the organizer can quickly scan it and identify you. But remember, you will need to register for the event beforehand.","",""),
            createStyledFaq("What is the “Profile” section for?","In the Profile section, you can find all your information, and you can change it if necessary, any time. ","",""),
            createStyledFaq("How can I open my notifications?","Simply click on the bell icon located at the top right corner of the screen.","Question21A",""),
            createStyledFaq("What is the “Notifications” section for? ","The Notifications section is where you get important updates, like friend requests, event invitations, business opportunities, news, and more.","",""),
            createStyledFaq("Where should I contact for any issue, feedback or marketing purposes? ","You can email us at PINetworking@gmail.com. Our support team will respond quickly to assist you.","",""),
            createStyledFaq("What is the “”Friends” section for?","This section is where you can view your network of friends. You can send them messages to start conversations.","",""),
            createStyledFaq("How can I become a friend? ","To add someone as a friend, search for their profile from the Find Users section. Click Follow. \n  This sends them a friend request. Once they accept, they will be added to your friend list.","Question25A","Question25B"),
            createStyledFaq("What information can I have from my friends list? ","You can see their phone number, email, hobbies, company, and even the events they might attend.","Question26A","Question26B"),
            SizedBox(height: 10.sp,)
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

  Widget createStyledFaq(
      String question, String answer, String image1Name, String image2Name) {
    return FAQNew(
      question: question,
      answer: answer,
      image1Name: image1Name,
      image2Name: image2Name,
      ansPadding: EdgeInsets.all(15),
      showDivider: true,
      ansStyle: AppTextStyles.josefin(
          style: TextStyle(
              color: AppColors.kBlackColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600)),
      queStyle: AppTextStyles.josefin(
          style: TextStyle(
              color: AppColors.kPrimaryColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600)),
    );
  }
}
