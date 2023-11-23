import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/app_buttons/white_background_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';
import 'package:personal_injury_networking/ui/authentication/controller/auth_controller.dart';
import 'package:personal_injury_networking/ui/authentication/model/country_state_model.dart'
    as cs_model;
import 'package:personal_injury_networking/ui/authentication/view/create_auth_view.dart';
import 'package:provider/provider.dart';

import '../../../global/utils/app_text_styles.dart';
import '../../../global/utils/custom_snackbar.dart';
import '../model/job_position_model.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatefulWidget {
  SignUpScreen({required this.screenType, this.isUpdate, Key? key})
      : super(key: key);
  int screenType;

  bool? isUpdate;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  get shortestSide => MediaQuery.of(context).size.shortestSide;

  int hobbiesCount = 0;
  bool disableStateDropdown = true;
  List<String> selectedHobbies = [];

  void addItem(String item) {
    if (!selectedHobbies.contains(item)) {
      setState(() {
        selectedHobbies.add(item);
        hobbiesCount++;
      });
      setState(() {});
    }
  }

  void removeItem(String item) {
    setState(() {
      selectedHobbies.remove(item);
    });
  }

  cs_model.CountryStateModel countryStateModel =
      cs_model.CountryStateModel(error: false, msg: '', data: []);

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
    widget.screenType == 1
        ? textFieldController[0].text =
            Constants.userDisplayName.toString() != ''
                ? Constants.userDisplayName.toString()
                : ''
        : textFieldController[0].text = '';
    widget.screenType == 1
        ? textFieldController[5].text = Constants.userEmail.toString() != ''
            ? Constants.userEmail.toString()
            : ''
        : textFieldController[5].text = '';
    loadUserPositions();
    loadUserHobbies();
    // getCountries();
    super.initState();
  }

  // final CountryStateCityRepo _countryStateCityRepo = CountryStateCityRepo();
  // getCountries() async {
  //   //
  //   countryStateModel = await _countryStateCityRepo.getCountriesStates();
  //   countries.add('Select Country');
  //   states.add('Select State');
  //   for (var element in countryStateModel.data) {
  //     countries.add(element.name);
  //   }
  //   setState(() {});
  // }
  //
  // getStates() async {
  //   //
  //   for (var element in countryStateModel.data) {
  //     if (selectedCountry == element.name) {
  //       //
  //       setState(() {
  //         // resetCities();
  //       });
  //       //
  //       for (var state in element.states) {
  //         states.add(state.name);
  //       }
  //     }
  //   }
  //   //
  // }

  final textFieldController =
      List.generate(13, (i) => TextEditingController(), growable: true);
  int index = 1;
  final controller = PageController(initialPage: 0);
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  List<String> countries = ["Select Country", "United States"];
  List<String> states = ["Select State", "Florida"];

  String selectedCountry = 'United States';
  String selectedState = 'Florida';

  willPopCalled() async {
    if (index > 1) {
      setState(() {
        index = index - 1;
      });
      controller.previousPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    } else {
      if (widget.screenType == 1) {
        await FirebaseAuth.instance.signOut();
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const CreateAuthenticationView()),
            (route) => false);
      } else {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return willPopCalled();
      },
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        appBar: AppBar(
          // backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              width: 40.sp,
              height: 40.sp,
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.kWhiteColor,
                size: 18.sp,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizeBox(10.h),
                Column(
                  children: [
                    // GestureDetector(
                    //   onTap: () => willPopCalled(),
                    //   child: SizedBox(
                    //     width: 40.sp,
                    //     height: 40.sp,
                    //     child: Icon(
                    //       Icons.arrow_back_ios,
                    //       color: AppColors.kPrimaryColor,
                    //       size: 18.sp,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
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
                  child: GetwhiteButton(50.sp, () async {
                    if (index == 1) {
                      if (textFieldController[0].text.isEmpty &&
                              widget.isUpdate == null ||
                          textFieldController[0].text == '') {
                        CustomSnackBar(false)
                            .showInSnackBar('please enter first name', context);
                        return;
                      } else if (textFieldController[1].text.isEmpty) {
                        CustomSnackBar(false)
                            .showInSnackBar("please enter last name", context);
                        return;
                      } else if (textFieldController[2].text.isEmpty) {
                        CustomSnackBar(false).showInSnackBar(
                            "please enter company name", context);
                        return;
                      } else if (textFieldController[3].text.isEmpty) {
                        CustomSnackBar(false).showInSnackBar(
                            "please select your position or job", context);
                        return;
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
                      if (textFieldController[4].text.isEmpty) {
                        CustomSnackBar(false)
                            .showInSnackBar('please enter cell phone', context);
                        return;
                      } else if (widget.isUpdate == null &&
                          (textFieldController[5].text.isEmpty ||
                              !EmailValidator.validate(
                                  textFieldController[5].text) ||
                              textFieldController[5].text == '')) {
                        CustomSnackBar(false).showInSnackBar(
                            "please enter valid email", context);
                        return;
                      } else if (selectedCountry == "Select Country") {
                        CustomSnackBar(false).showInSnackBar(
                            "please select your country", context);
                        return;
                      } else if (selectedState == "Select State") {
                        CustomSnackBar(false).showInSnackBar(
                            "please select your state", context);
                        return;
                      } else if (textFieldController[8].text.isEmpty ||
                          selectedHobbies.length < 3) {
                        CustomSnackBar(false).showInSnackBar(
                            "Please select atleast 3 hobbies!", context);
                        return;
                      } else if (textFieldController[9].text.isEmpty) {
                        CustomSnackBar(false).showInSnackBar(
                            "please enter your reference", context);
                        return;
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
                      if (textFieldController[10].text.isEmpty) {
                        CustomSnackBar(false)
                            .showInSnackBar('please enter user name', context);
                        return;
                      } else if (textFieldController[11].text.length < 6 &&
                          widget.screenType == 0) {
                        CustomSnackBar(false).showInSnackBar(
                            'Password is too short! must be greater than 6 digits',
                            context);
                        return;
                      } else if (textFieldController[11].text !=
                              textFieldController[12].text &&
                          widget.screenType == 0) {
                        CustomSnackBar(false).showInSnackBar(
                            'password and confirm password should be same!',
                            context);
                        return;
                      } else {
                        if (FirebaseAuth.instance.currentUser != null) {
                          context.read<AuthController>().updateUser(context,
                              firstName: textFieldController[0].text,
                              email: textFieldController[5].text,
                              lastName: textFieldController[1].text,
                              companyName: textFieldController[2].text,
                              website: textFieldController[6].text,
                              phone: textFieldController[4].text,
                              position: textFieldController[3].text,
                              location: "$selectedState,$selectedCountry",
                              reference: textFieldController[9].text,
                              hobbies: selectedHobbies,
                              userName: textFieldController[10].text);
                        } else {
                          context.read<AuthController>().signup(context,
                              firstName: textFieldController[0].text,
                              lastName: textFieldController[1].text,
                              companyName: textFieldController[2].text,
                              position: textFieldController[3].text,
                              phone: textFieldController[4].text,
                              email: textFieldController[5].text,
                              website: textFieldController[6].text,
                              location: "$selectedState,$selectedCountry",
                              reference: textFieldController[9].text,
                              password: textFieldController[11].text,
                              hobbies: selectedHobbies,
                              userName: textFieldController[10].text);
                        }
                      }
                    }
                  },
                      Text(
                        index < 3 ? "Next" : "Save",
                        style: AppTextStyles.josefin(
                          style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 18.sp,
                          ),
                        ),
                      )),
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
          textField('First Name', 'Jon', 0, textFieldController[0],
              Constants.userDisplayName.toString() == '' ? false : true, false),
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
              inputType: TextInputType.number, maxLength: 12),
          textField('Email', 'abc@gmail.com', 5, textFieldController[5],
              Constants.userEmail.toString() == '' ? false : true, false),
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
          locationField(),
          CustomSizeBox(22.h),
          textField('Hobbies/Interests', 'Click here to enter', 8,
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
                          // height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w, left: 10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      selectedHobbies[index].toString(),
                                      style: AppTextStyles.josefin(
                                          style: TextStyle(
                                              color: AppColors.kPrimaryColor,
                                              fontSize: 12.sp)),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        hobbiesCount--;
                                        removeItem(selectedHobbies[index]);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.w),
                                        child: Icon(
                                          Icons.cancel_outlined,
                                          size: 20.sp,
                                          color: AppColors.kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox(),
          hobbiesCount > 0 ? CustomSizeBox(22.h) : const SizedBox(),
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
          widget.screenType == 0
              ? textField('Password', 'xxxxxxxxx', 11, textFieldController[11],
                  false, hidePassword)
              : const SizedBox(),
          if (widget.screenType == 0)
            textField('Confirm Password', 'xxxxxxxxx', 12,
                textFieldController[12], false, hideConfirmPassword),
          CustomSizeBox(20.h)
        ],
      ),
    );
  }

  Widget textField(String identityText, String hintText, int index,
      TextEditingController controller, bool readOnly, bool obsecureTerxt,
      {TextInputType? inputType, int? maxLength}) {
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
            inputFormatters: index == 4
                ? [FilteringTextInputFormatter.deny(RegExp(r'\s'))]
                : null,
            maxLength: maxLength,
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
              } else if (index == 4 && textFieldController[4].text.isEmpty) {
                textFieldController[4].text = '+1';
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
                          addItem(JobPositionModel.hobbiesList[i]
                              .substring(2)
                              .toString());
                          // if (hobbiesCount == 0) {
                          //   hobbiesCount++;
                          // }
                        });
                      }
                    }
                  }
                });
              }
            },
            decoration: InputDecoration(
              counterText: "",
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
                                                addItem(JobPositionModel
                                                    .hobbiesList[i]
                                                    .substring(2)
                                                    .toString());
                                                // if (hobbiesCount == 0) {
                                                //   hobbiesCount++;
                                                // }
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
                  top: index == 3 || index == 12 || index == 11
                      ? 12.h
                      : index == 8
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

  Widget locationField() {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedCountry,
                items: countries
                    .map((String country) =>
                        DropdownMenuItem(value: country, child: Text(country)))
                    .toList(),
                onChanged: (selectedValue) {
                  if (selectedValue != null) {
                    setState(() {
                      selectedCountry = selectedValue;
                      disableStateDropdown = false;
                      // resetStates();
                    });
                    // if (selectedCountry != 'Select Country') {
                    //   getStates();
                    // }
                  }
                },
                underline: Container(),
                style: AppTextStyles.josefin(
                  style: TextStyle(
                    color: const Color(0xFF1F314A),
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 18.w,
        ),
        Flexible(
          child: IgnorePointer(
            ignoring: disableStateDropdown,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedState,
                  items: states
                      .map((String state) =>
                          DropdownMenuItem(value: state, child: Text(state)))
                      .toList(),
                  onChanged: (selectedValue) {
                    setState(() {
                      selectedState = selectedValue!;
                    });
                  },
                  underline: Container(),
                  style: AppTextStyles.josefin(
                    style: TextStyle(
                      color: const Color(0xFF1F314A),
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

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

  resetStates() {
    states = [];
    states.add('Select State');
    selectedState = 'Select State';
  }
}
