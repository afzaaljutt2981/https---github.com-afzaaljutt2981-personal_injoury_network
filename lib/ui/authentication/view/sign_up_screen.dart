import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/app_buttons/white_background_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/ui/authentication/controller/auth_controller.dart';
import 'package:provider/provider.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../../global/utils/custom_snackbar.dart';
import '../../home/view/navigation_view.dart';
import '../model/job_position_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  get shortestSide => MediaQuery.of(context).size.shortestSide;
  loadUserPositions() {
    JobPositionModel.dropdownItems = [];
    for (int i = 0; i < JobPositionModel.jobList.length; i++) {
      JobPositionModel.dropdownItems.add(PopupMenuItem<String>(
          value: JobPositionModel.jobList[i],
          child: Text(
            JobPositionModel.jobList[i],
            style: AppTextStyles.josefin(
              style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
            ),
          )));
    }
  }

  int hobbiesCount = 0;
  List<String> selectedHobbies = [];

  void addItem(String item) {
    setState(() {
      selectedHobbies.add(item);
    });
  }

  void removeItem(String item) {
    setState(() {
      selectedHobbies.remove(item);
    });
  }

  loadUserHobbies() {
    JobPositionModel.hobbiesDropDown = [];
    for (int i = 0; i < JobPositionModel.hobbiesList.length; i++) {
      JobPositionModel.hobbiesDropDown.add(PopupMenuItem<String>(
          value: JobPositionModel.hobbiesList[i],
          child: Text(
            JobPositionModel.hobbiesList[i],
            style: AppTextStyles.josefin(
              style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
            ),
          )));
    }
  }

  @override
  void initState() {
    loadUserPositions();
    loadUserHobbies();
    super.initState();
  }

  final textFieldController =
      List.generate(13, (i) => TextEditingController(), growable: true);
  int index = 1;
  final controller = PageController(initialPage: 0);
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    bool saveChagesButton = context.watch<AuthController>().saveChagesButton;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizeBox(40.h),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // if (index == 1) {
                      Navigator.pop(context);
                      // } else {
                      //   setState(() {
                      //     index--;
                      //   });
                      // }
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                ],
              ),
              CustomSizeBox(10.h),
              Center(
                child: Image(
                  height: 90.sp,
                  width: 90.sp,
                  image: const AssetImage('assets/images/primary_icon.png'),
                ),
              ),
              CustomSizeBox(20.h),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.sp),
                  child: Text(
                    'Create Account',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.josefin(
                      style: TextStyle(
                        height: 1.1.sp,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              CustomSizeBox(15.h),
              processStagesCount(index),
              CustomSizeBox(25.h),
              SizedBox(
                height: index == 2 ? 350.h : 320.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: PageView(
                    controller: controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      process1(),
                      process2(),
                      process3(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                    bottom: index == 3 ? 15.h : 30.h, //0.h,
                    top: index == 3
                        ? 15.h
                        : index == 2
                            ? 10.h
                            : 25.h),
                child: GetwhiteButton(
                  50.sp,
                  () async {
                    if (index == 1) {
                      if (textFieldController[0].text.isEmpty ||
                          textFieldController[1].text.isEmpty ||
                          textFieldController[2].text.isEmpty ||
                          textFieldController[3].text.isEmpty) {
                        CustomSnackBar(false)
                            .showInSnackBar('Some fields are empty!', context);
                      } else {
                        setState(() {
                          index = index + 1;
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        });
                      }
                    } else if (index == 2) {
                      if (textFieldController[4].text.isEmpty ||
                          textFieldController[5].text.isEmpty ||
                          textFieldController[9].text.isEmpty) {
                        CustomSnackBar(false)
                            .showInSnackBar('Some fields are empty!', context);
                      } else {
                        setState(() {
                          index = index + 1;
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        });
                      }
                    }
                    if (index == 3) {
                      if (textFieldController[10].text.isEmpty ||
                          textFieldController[11].text.isEmpty ||
                          textFieldController[12].text.isEmpty) {
                        CustomSnackBar(false)
                            .showInSnackBar('Some fields are empty!', context);
                      } else if (textFieldController[11].text.length < 6) {
                        CustomSnackBar(false).showInSnackBar(
                            'Password is too short! must be greter than 6 digits',
                            context);
                      } else if (textFieldController[11].text !=
                          textFieldController[12].text) {
                        CustomSnackBar(false).showInSnackBar(
                            'Both passwords are not same!', context);
                      } else {
                        context
                            .read<AuthController>()
                            .setSaveChangesButtonStatus(true);
                        context.read<AuthController>().signup(context,
                            firstName: textFieldController[0].text,
                            lastName: textFieldController[1].text,
                            companyName: textFieldController[2].text,
                            website: textFieldController[3].text,
                            phone: textFieldController[4].text,
                            email: textFieldController[5].text,
                            position: textFieldController[6].text,
                            location: textFieldController[7].text,
                            password: textFieldController[8].text,
                            hobbies: textFieldController[9].text,
                            userName: textFieldController[10].text);
                        Navigator.push(
                          context,
                          PageTransition(
                            childCurrent: widget,
                            type: PageTransitionType.leftToRight,
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 200),
                            reverseDuration: const Duration(milliseconds: 200),
                            child: BottomNavigationScreen(
                              selectedIndex: 0,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  Text(
                    saveChagesButton == false && index < 3 ? "Next" : "Save",
                    style: AppTextStyles.josefin(
                      style: TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
              index == 3
                  ? Center(
                      child: SizedBox(
                        width: 250.w,
                        child: Column(
                          children: [
                            Text(
                              'By click Save you are agree with ',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.josefin(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.sp)),
                            ),
                            CustomSizeBox(5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'our ',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.josefin(
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.sp)),
                                ),
                                Text(
                                  'Terms and Condition ',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.josefin(
                                      style: TextStyle(
                                          color: const Color(0xFFF63636),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.sp)),
                                )
                              ],
                            ),
                            CustomSizeBox(20.h),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget processStagesCount(index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 20.sp,
          width: 20.sp,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          child: Center(
            child: Text(
              "1",
              style: AppTextStyles.josefin(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 1.5.sp,
          width: 60.sp,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        Container(
          height: 20.sp,
          width: 20.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < 2 ? Colors.white : Colors.red,
          ),
          child: Center(
            child: Text(
              "2",
              style: AppTextStyles.josefin(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 1.5.sp,
          width: 60.sp,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
        Container(
          height: 20.sp,
          width: 20.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < 3 ? Colors.white : Colors.red,
          ),
          child: Center(
            child: Text(
              "3",
              style: AppTextStyles.josefin(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget process1() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          textField(
              'First Name', 'Jon', 0, textFieldController[0], false, false),
          textField(
              'Last Name', 'Methon', 1, textFieldController[1], false, false),
          textField('Company', 'Enter Company name', 2, textFieldController[2],
              false, false),
          textField(
            'Position/Job',
            'Select here',
            3,
            textFieldController[3],
            true,
            false,
          ),
          CustomSizeBox(20.h)
        ],
      ),
    );
  }

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  Widget process2() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textField('Cell Phone', '+1 356 786 7865', 4, textFieldController[4],
              false, false,
              inputType: TextInputType.number),
          textField('Email', 'abc@gmail.com', 5, textFieldController[5], false,
              false),
          textField('Website (Optional)', 'Enter Website name', 6,
              textFieldController[6], false, false),
          Text(
            'Location',
            style: AppTextStyles.josefin(
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500)),
          ),
          CustomSizeBox(5.h),
          CSCPicker(
            showStates: true,
            flagState: CountryFlag.DISABLE,
            dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1)),
            disabledDropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.grey.shade300, width: 1)),

            ///placeholders for dropdown search field
            countrySearchPlaceholder: "Country",
            stateSearchPlaceholder: "State",

            ///labels for dropdown
            // countryDropdownLabel: "Country",
            // stateDropdownLabel: "State",

            selectedItemStyle: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
            ),

            ///DropdownDialog Heading style [OPTIONAL PARAMETER]
            dropdownHeadingStyle: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold),

            ///DropdownDialog Item style [OPTIONAL PARAMETER]
            dropdownItemStyle: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
            ),

            ///Dialog box radius [OPTIONAL PARAMETER]
            dropdownDialogRadius: 10.0,

            ///Search bar radius [OPTIONAL PARAMETER]
            searchBarRadius: 10.0,

            ///triggers once country selected in dropdown
            onCountryChanged: (value) {
              print(value.toString());
              print("cccc" + countryValue.toString());

              setState(() {
                countryValue = value;
                //  countryDropdownLabel = value;
              });
            },

            ///triggers once state selected in dropdown
            onStateChanged: (value) {
              if (value != null) {
                setState(() {
                  stateValue = value;
                });
              }
            },
          ),
          // locationField(),
          CustomSizeBox(22.h),
          textField('Hobbies/Interests (Optional)', 'Click here to enter', 8,
              textFieldController[8], true, false),

          hobbiesCount != 0
              ? SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedHobbies.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 5.h, right: 0.h),
                                    child: GestureDetector(
                                      onTap: () {
                                        hobbiesCount--;
                                        removeItem(selectedHobbies[index]);
                                      },
                                      child: Icon(
                                        Icons.cancel_outlined,
                                        size: 15.sp,
                                        color: AppColors.kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.w, right: 10.w, bottom: 5.h),
                                child: Text(
                                  selectedHobbies[index].toString(),
                                  style: AppTextStyles.josefin(
                                      style: TextStyle(
                                          color: AppColors.kPrimaryColor,
                                          fontSize: 12.sp)),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox(),
          hobbiesCount > 0 ? CustomSizeBox(22.h) : SizedBox(),
          textField('What brings you here?', 'Connecting people?', 9,
              textFieldController[9], false, false),
          CustomSizeBox(20.h)
        ],
      ),
    );
  }

  Widget process3() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          textField('Username', 'Enter username', 10, textFieldController[10],
              false, false),
          textField('Password', 'xxxxxxxxx', 11, textFieldController[11], false,
              hidePassword),
          textField('Confirm Password', 'xxxxxxxxx', 12,
              textFieldController[12], false, hideConfirmPassword),
          CustomSizeBox(20.h)
        ],
      ),
    );
  }

  Widget textField(String identityText, String hintText, int index,
      TextEditingController controller, bool readOnly, bool obsecureTerxt,
      {TextInputType? inputType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          identityText,
          style: AppTextStyles.josefin(
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500)),
        ),
        CustomSizeBox(5.h),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp), color: Colors.white),
          child: TextFormField(
            keyboardType: inputType,
            obscureText: obsecureTerxt,
            readOnly: readOnly,
            controller: controller,
            style: AppTextStyles.josefin(
              style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400),
            ),
            onTap: () {
              if (index == 3) {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                      shortestSide > 600 ? 100 : 50.w,
                      shortestSide > 600 ? 0 : 100,
                      shortestSide > 600 ? 100 : 10.w,
                      shortestSide > 600 ? 100 : 100),
                  items: [...JobPositionModel.dropdownItems],
                ).then((value) {
                  if (value != null) {
                    textFieldController[3].text = value.toString().substring(2);

                    for (int i = 0; i < JobPositionModel.jobList.length; i++) {
                      if (value
                          .toString()
                          .contains(JobPositionModel.jobList[i])) {
                        JobPositionModel.selectedJob =
                            JobPositionModel.jobList[i].substring(2);
                      }
                    }
                  }
                });
              } else if (index == 8 && hobbiesCount < 3) {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                      shortestSide > 600 ? 100 : 50.w,
                      shortestSide > 600 ? 0 : 100,
                      shortestSide > 600 ? 100 : 10.w,
                      shortestSide > 600 ? 100 : 100),
                  items: [...JobPositionModel.hobbiesDropDown],
                ).then((value) {
                  if (value != null) {
                    textFieldController[8].text = value.toString().substring(2);

                    for (int i = 0;
                        i < JobPositionModel.hobbiesList.length;
                        i++) {
                      if (value
                          .toString()
                          .contains(JobPositionModel.hobbiesList[i])) {
                        setState(() {
                          hobbiesCount++;
                          addItem(JobPositionModel.hobbiesList[i]
                              .substring(2)
                              .toString());
                        });
                      }
                    }
                  }
                });
              }
            },
            decoration: InputDecoration(
              suffixIcon: index == 3
                  ? GestureDetector(
                      onTap: () {
                        showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(
                              shortestSide > 600 ? 100 : 50.w,
                              shortestSide > 600 ? 0 : 100,
                              shortestSide > 600 ? 100 : 10.w,
                              shortestSide > 600 ? 100 : 100),
                          items: [...JobPositionModel.dropdownItems],
                        ).then((value) {
                          if (value != null) {
                            textFieldController[3].text =
                                value.toString().substring(2);

                            for (int i = 0;
                                i < JobPositionModel.jobList.length;
                                i++) {
                              if (value
                                  .toString()
                                  .contains(JobPositionModel.jobList[i])) {
                                JobPositionModel.selectedJob =
                                    JobPositionModel.jobList[i].substring(2);
                              }
                            }
                          }
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(14.sp),
                        child: Image(
                            width: 10.sp,
                            height: 10.sp,
                            image: const AssetImage(
                                'assets/images/arrow_down_signup.png')),
                      ))
                  : index == 11
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          child: hidePassword
                              ? const Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.grey,
                                ))
                      : index == 12
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  hideConfirmPassword = !hideConfirmPassword;
                                });
                              },
                              child: hideConfirmPassword
                                  ? const Icon(
                                      Icons.visibility_off_outlined,
                                      color: Colors.grey,
                                    )
                                  : const Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.grey,
                                    ))
                          : (index == 8)
                              ? GestureDetector(
                                  onTap: () {
                                    if (hobbiesCount < 3) {
                                      showMenu(
                                        context: context,
                                        position: RelativeRect.fromLTRB(
                                            shortestSide > 600 ? 100 : 50.w,
                                            shortestSide > 600 ? 0 : 100,
                                            shortestSide > 600 ? 100 : 10.w,
                                            shortestSide > 600 ? 100 : 100),
                                        items: [
                                          ...JobPositionModel.hobbiesDropDown
                                        ],
                                      ).then((value) {
                                        if (value != null) {
                                          textFieldController[8].text =
                                              value.toString().substring(2);

                                          for (int i = 0;
                                              i <
                                                  JobPositionModel
                                                      .hobbiesList.length;
                                              i++) {
                                            if (value.toString().contains(
                                                JobPositionModel
                                                    .hobbiesList[i])) {
                                              setState(() {
                                                hobbiesCount++;
                                              });
                                            }
                                          }
                                        }
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(14.sp),
                                    child: Image(
                                      width: 10.sp,
                                      height: 10.sp,
                                      image: const AssetImage(
                                          'assets/images/arrow_down_signup.png'),
                                      color: hobbiesCount < 3
                                          ? AppColors.kPrimaryColor
                                          : Colors.grey[400],
                                    ),
                                  ))
                              : null,
              contentPadding: EdgeInsets.only(
                  left: 10.w,
                  top: index == 3 || index == 12 || index == 11 || index == 8
                      ? 12.h
                      : 0.h,
                  right: index == 3 || index == 8 ? 10.w : 5.w),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: AppTextStyles.josefin(
                style: TextStyle(
                  color: const Color(0xFF1F314A).withOpacity(0.31),
                  fontSize: 14.sp,
                ),
              ),
            ),
            textInputAction: index == 2 || index == 9 || index == 12
                ? TextInputAction.done
                : TextInputAction.next,
          ),
        ),
        CustomSizeBox(22.h)
      ],
    );
  }

  String? state;
  String? country;
  Widget locationField() {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.sp)),
          child: TextFormField(
            onTap: () {
              // getContries();
            },
            readOnly: true,
            maxLines: 1,
            controller: textFieldController[7],
            style: AppTextStyles.josefin(
                style:
                    TextStyle(color: const Color(0xFF1F314A), fontSize: 15.sp)),
            decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: EdgeInsets.all(14.sp),
                  child: Image(
                      width: 10.sp,
                      height: 10.sp,
                      image: const AssetImage(
                          'assets/images/arrow_down_signup.png')),
                ),
                contentPadding: EdgeInsets.only(left: 10.w, top: 13.h),
                border: InputBorder.none,
                hintText: 'Country',
                hintStyle: AppTextStyles.josefin(
                    style: TextStyle(
                        color: const Color(0xFF1F314A).withOpacity(0.40),
                        fontSize: 15.sp))),
          ),
        )),
        SizedBox(
          width: 18.w,
        ),
        Flexible(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.sp)),
          child: TextFormField(
            onTap: () {},
            readOnly: true,
            maxLines: 1,
            controller: textFieldController[7],
            style: AppTextStyles.josefin(
                style:
                    TextStyle(color: const Color(0xFF1F314A), fontSize: 15.sp)),
            decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: EdgeInsets.all(14.sp),
                  child: Image(
                      width: 10.sp,
                      height: 10.sp,
                      image: const AssetImage(
                          'assets/images/arrow_down_signup.png')),
                ),
                contentPadding: EdgeInsets.only(left: 10.w, top: 13.h),
                border: InputBorder.none,
                hintText: 'State',
                hintStyle: AppTextStyles.josefin(
                    style: TextStyle(
                        color: const Color(0xFF1F314A).withOpacity(0.40),
                        fontSize: 15.sp))),
          ),
        )),
      ],
    );
  }
}
