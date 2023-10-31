import 'package:flutter/material.dart';

class JobPositionModel {
  static var jobList = [
    '- Chiropractic Business Development',
    '- Chiropractic Doctor owner',
    '- Chiropractic Doctor',
    '- Chiropractic other',
    '- Attorney Owner',
    '- Attorney Associate',
    '- Attorney Business Development',
    '- Attorney Case Manager',
    '- Attorney other',
    '- Orthopedic Doctor owner',
    '- Orthopedic Associate',
    '- Orthopedic Business Development',
    '- Orthopedic Doctor',
    '- Orthopedic other',
    '- MRI Owner',
    '- MRI Associate',
    '- MRI Business Development',
    '- MRI other',
    '- Medical Devices owner',
    '- Medical Devices Associate',
    '- Medical Devices Business Development',
    '- Medical devices other',
    '- Pain Management Owner',
    '- Pain Management Associate',
    '- Pain Management Business Development',
    '- Pain Management Doctor',
    '- Pain Management other',
    '- Massage Therapist',
    '- Marketing',
    '- Nurse',
    '- Other'
  ];
  static String? selectedJob;
  static List<PopupMenuItem<String>> dropdownItems = [];

  static var hobbiesList = [
    '- Golf',
    '- Tennis',
    '- Pickleball',
    '- wine and food testing',
    '- Reading ',
    '- Traveling ',
    '- Car show',
    '- NBA games ',
    '- Super Bowl games',
    '- Boating',
    '- Any sport activités',
    '- Any type of shows',
    '- Painting',
    '- Art & Pottery',
    '- Chess',
    '- Yoga',
    '- Singing/ Karaoke ',
    '- Bowling',
    '- Concert',
    '- Biking',
    '- Casino'
  ];

  
  static List<PopupMenuItem<String>> hobbiesDropDown = [];
}
