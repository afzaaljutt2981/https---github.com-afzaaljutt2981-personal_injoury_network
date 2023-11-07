import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/app_buttons/white_background_button.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';
import 'package:personal_injury_networking/global/utils/functions.dart';
import 'package:personal_injury_networking/ui/authentication/controller/auth_controller.dart';
import 'package:personal_injury_networking/ui/authentication/view/sign_up_screen.dart';
import 'package:personal_injury_networking/ui/home/view/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/custom_snackbar.dart';
import '../../forgetPassword/view/create_forget_pass_controller.dart';
import '../../forgetPassword/view/forget_view.dart';
import '../../home/view/navigation_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final textFieldController =
      List.generate(2, (i) => TextEditingController(), growable: true);
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              CustomSizeBox(65.h),
              Center(
                child: Image(
                  height: 70.sp,
                  width: 70.sp,
                  image: const AssetImage('assets/images/primary_icon.png'),
                ),
              ),
              CustomSizeBox(20.h),
              Center(
                child: Image(
                  height: 30.sp,
                  width: 130.sp,
                  image: const AssetImage('assets/images/hi_login.png'),
                ),
              ),
              CustomSizeBox(10.h),
              Center(
                  child: Text(
                'Welcome back, Sign in to your account',
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400)),
              )),
              CustomSizeBox(20.h),
              textField('Username/Email', 'Enter username/Email', 0,
                  textFieldController[0], false),
              CustomSizeBox(15.h),
              textField('Password', 'xxxxxxxxx', 1, textFieldController[1],
                  hidePassword),
              CustomSizeBox(10.h),
              SizedBox(
                width: screenWidth,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        childCurrent: widget,
                        type: PageTransitionType.rightToLeft,
                        alignment: Alignment.center,
                        duration: const Duration(milliseconds: 200),
                        reverseDuration: const Duration(milliseconds: 200),
                        child: const CreateForgetPasswordView(),
                      ),
                    );
                  },
                  child: Text(
                    'Forget Password?',
                    style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                  top: 30.h,
                ),
                child: GetwhiteButton(50.h, () {
                  if (textFieldController[0].text.isEmpty ||
                      !(EmailValidator.validate(textFieldController[0].text))) {
                    CustomSnackBar(false)
                        .showInSnackBar('Please enter valid email!', context);
                    return;
                  } else if (textFieldController[1].text.isEmpty) {
                    CustomSnackBar(false)
                        .showInSnackBar('Password field is empty!', context);
                    return;
                  } else {
                    context.read<AuthController>().signIn(
                        textFieldController[0].text,
                        textFieldController[1].text,
                        context);
                    // Navigator.push(
                    //   context,
                    //   PageTransition(
                    //     childCurrent: widget,
                    //     type: PageTransitionType.rightToLeft,
                    //     alignment: Alignment.center,
                    //     duration: const Duration(milliseconds: 200),
                    //     reverseDuration: const Duration(milliseconds: 200),
                    //     child: BottomNavigationScreen(
                    //       selectedIndex: 0,
                    //     ),
                    //   ),
                    // );
                  }
                },
                    Text(
                      "Login",
                      style: AppTextStyles.josefin(
                          style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp)),
                    )),
              ),
              CustomSizeBox(14.h),
              Center(
                child: Image(
                  height: 30.sp,
                  width: screenWidth,
                  image: const AssetImage('assets/images/or_login.png'),
                ),
              ),
              CustomSizeBox(14.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  loginGoogleApple('assets/images/google_login.png', onTap: () {
                    signInWithGoogle();
                  }),
                  loginGoogleApple('assets/images/apple_login.png', onTap: () {
                    signInWithApple();
                  })
                ],
              ),
              CustomSizeBox(24.h),
              SizedBox(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: AppTextStyles.josefin(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      textAlign: TextAlign.end,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            childCurrent: widget,
                            type: PageTransitionType.rightToLeft,
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 200),
                            reverseDuration: const Duration(milliseconds: 200),
                            child: ChangeNotifierProvider(
                                create: (_) => AuthController(),
                                child: SignUpScreen(
                                  screenType: 0,
                                )),
                          ),
                        );
                      },
                      child: Text(
                        ' Sign Up',
                        style: AppTextStyles.josefin(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              CustomSizeBox(20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginGoogleApple(String image, {required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.kPrimaryColor,
            borderRadius: BorderRadius.circular(15.sp),
            border: Border.all(color: Colors.white)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 13.h),
          child: Center(
            child: Image(height: 20.sp, width: 20.sp, image: AssetImage(image)),
          ),
        ),
      ),
    );
  }

  Widget textField(String identityText, String hintText, int index,
      TextEditingController controller, bool obsecureTerxt) {
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
            obscureText: obsecureTerxt,
            readOnly: false,
            textInputAction:
                index == 0 ? TextInputAction.next : TextInputAction.done,
            controller: controller,
            style: AppTextStyles.josefin(
              style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400),
            ),
            decoration: InputDecoration(
              suffixIcon: index == 0
                  ? null
                  : GestureDetector(
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
                            )),
              contentPadding: EdgeInsets.only(
                  left: 10.w,
                  top: index == 0 ? 0.h : 14.h,
                  right: index == 0 ? 10.w : 0.h),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: AppTextStyles.josefin(
                style: TextStyle(
                  color: const Color(0xFF1F314A).withOpacity(0.31),
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        Constants.userDisplayName = user.displayName!;
        Constants.userEmail = user.email!;
        Constants.uId = user.uid;
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          PageTransition(
            childCurrent: widget,
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 200),
            reverseDuration: const Duration(milliseconds: 200),
            child: ChangeNotifierProvider(
                create: (_) => AuthController(),
                child: SignUpScreen(
                  screenType: 1,
                )),
          ),
        );
      }
      return user;
    } catch (error) {
      CustomSnackBar(false).showInSnackBar(error.toString(), context);
      return null;
    }
  }

  Future<User> signInWithApple({List<Scope> scopes = const []}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        final AppleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
            idToken: String.fromCharCodes(AppleIdCredential.identityToken!));
        final UserCredential = await auth.signInWithCredential(credential);
        final firebaseUser = UserCredential.user!;
        if (scopes.contains(Scope.fullName)) {
          final fullName = AppleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName} ${fullName.familyName}';

            Constants.userDisplayName = displayName;
            Constants.userEmail = '';
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              PageTransition(
                childCurrent: widget,
                type: PageTransitionType.rightToLeft,
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 200),
                reverseDuration: const Duration(milliseconds: 200),
                child: ChangeNotifierProvider(
                    create: (_) => AuthController(),
                    child: SignUpScreen(
                      screenType: 1,
                    )),
              ),
            );
          }
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
            code: 'ERROR_AUTHORIZATION_DENIED',
            message: result.error.toString());

      case AuthorizationStatus.cancelled:
        throw PlatformException(
            code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');

      default:
        throw UnimplementedError();
    }
  }
}
