// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking/app/modules/splash/controllers/splash_controller.dart';
import 'package:foodking/main.dart';
import 'package:get/get.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/loader.dart';
import '../controllers/auth_controller.dart';
import 'forget_password_view.dart';
import 'phone_number_view.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();

  bool passwordVisible = false;
  bool rememberMe = false;
  final splashController = Get.find<SplashController>();
  final authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    rememberMe = box.read('remember') ?? false;

    if (rememberMe) {
      authController.emailController.text = box.read('email') ?? "";
    } else {
      box.remove('email');
      box.remove('password');
      authController.emailController.text = "";
      authController.passwordController.text = "";
    }

    if (splashController.configData.demo == true) {
      authController.emailController.text = "customer@example.com";
      authController.passwordController.text = "123456";
    }
  }

  InputDecoration _fieldDecoration({Widget? suffixIcon}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(width: 1.w, color: AppColor.primaryColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(width: 1.w, color: AppColor.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(color: AppColor.primaryColor, width: 1.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(width: 1.w, color: AppColor.dividerColor),
      ),
      suffixIcon: suffixIcon,
    );
  }

  ButtonStyle _pillButtonStyle({
    required Color backgroundColor,
    Color? borderColor,
  }) {
    return ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: backgroundColor,
      minimumSize: Size(double.infinity, 54.h),
      shape: RoundedRectangleBorder(
        side: borderColor == null
            ? BorderSide.none
            : BorderSide(width: 1.w, color: borderColor),
        borderRadius: BorderRadius.circular(27.r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) => Stack(
        children: [
          Scaffold(
            backgroundColor: AppColor.primaryBackgroundColor,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: AppColor.primaryBackgroundColor,
              leading: IconButton(
                icon: SvgPicture.asset(
                  Images.back,
                  colorFilter: ColorFilter.mode(
                    AppColor.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: SafeArea(
              top: false,
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Column(
                    children: [
                      SizedBox(height: 12.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 18.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.58),
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(
                            color: AppColor.dividerColor,
                            width: 1.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.primaryColor.withValues(
                                alpha: 0.06,
                              ),
                              blurRadius: 24.r,
                              offset: Offset(0, 12.h),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'WELCOME_BACK'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w700,
                                fontSize: 24.sp,
                                color: AppColor.fontColor,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Sign in to continue your order',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColor.textSignupColor,
                                fontSize: 13.sp,
                                fontFamily: 'Rubik',
                              ),
                            ),
                            SizedBox(height: 26.h),
                            Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('EMAIL'.tr, style: fontRegularBold),
                                  SizedBox(height: 6.h),
                                  TextFormField(
                                    controller: authController.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [AutofillHints.email],
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                          ).hasMatch(value)) {
                                        return "Enter valid email";
                                      }
                                      return null;
                                    },
                                    decoration: _fieldDecoration(),
                                  ),
                                  SizedBox(height: 16.h),
                                  Text('PASSWORD'.tr, style: fontRegularBold),
                                  SizedBox(height: 6.h),
                                  TextFormField(
                                    obscureText: passwordVisible,
                                    controller:
                                        authController.passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                    autofillHints: const [
                                      AutofillHints.password,
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !RegExp(r"^.{6,}").hasMatch(value)) {
                                        return "Password must be at least 6 charecter";
                                      }
                                      return null;
                                    },
                                    decoration: _fieldDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppColor.gray,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            passwordVisible = !passwordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            rememberMe = !rememberMe;
                                            box.write('remember', rememberMe);
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 16.w,
                                              height: 16.h,
                                              child: rememberMe
                                                  ? SvgPicture.asset(
                                                      Images.iconTickedYes,
                                                      fit: BoxFit.cover,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                            AppColor
                                                                .primaryColor,
                                                            BlendMode.srcIn,
                                                          ),
                                                    )
                                                  : SvgPicture.asset(
                                                      Images.iconTickedNo,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                            SizedBox(width: 6.w),
                                            Text(
                                              'REMEMBER_ME'.tr,
                                              style: fontRegular,
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => const ForgetPasswordView(),
                                            duration: const Duration(
                                              milliseconds: 400,
                                            ),
                                            transition: Transition.rightToLeft,
                                          );
                                        },
                                        child: Text(
                                          'FORGOT_PASSWORD'.tr,
                                          style: TextStyle(
                                            color: AppColor.primaryColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Rubik',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24.h),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          authController.login(
                                            authController.emailController.text,
                                            authController
                                                .passwordController
                                                .text,
                                          );
                                        }
                                      },
                                      style: _pillButtonStyle(
                                        backgroundColor: AppColor.primaryColor,
                                      ),
                                      child: Text(
                                        "LOGIN".tr,
                                        style: fontMedium.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'DONT_HAVE_AN_ACCOUNT'.tr,
                                          style: TextStyle(
                                            color: AppColor.textSignupColor,
                                            fontSize: 14.sp,
                                            fontFamily: 'Rubik',
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                            () =>
                                                PhoneNumberView(isGuest: false),
                                            duration: const Duration(
                                              milliseconds: 400,
                                            ),
                                            transition: Transition.rightToLeft,
                                          );
                                        },
                                        child: Text(
                                          'SIGN_UP'.tr,
                                          style: TextStyle(
                                            color: AppColor.primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            fontFamily: 'Rubik',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (splashController.configData.siteGuestLogin !=
                                    10 ||
                                authController.hasGoogleLogin) ...[
                              SizedBox(height: 20.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: AppColor.dividerColor,
                                      thickness: 1.h,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                    ),
                                    child: Text(
                                      'OR'.tr,
                                      style: TextStyle(
                                        color: AppColor.textSignupColor,
                                        fontSize: 13.sp,
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppColor.dividerColor,
                                      thickness: 1.h,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              if (authController.hasGoogleLogin)
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await authController.googleLogin();
                                    },
                                    style: _pillButtonStyle(
                                      backgroundColor: Colors.white,
                                      borderColor: AppColor.dividerColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/google.svg',
                                          width: 22.w,
                                          height: 22.w,
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          "Login with Google",
                                          style: TextStyle(
                                            color: AppColor.fontColor,
                                            fontFamily: 'Rubik',
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (authController.hasGoogleLogin &&
                                  splashController.configData.siteGuestLogin !=
                                      10)
                                SizedBox(height: 12.h),
                              if (splashController.configData.siteGuestLogin !=
                                  10)
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(
                                        () => PhoneNumberView(isGuest: true),
                                      );
                                    },
                                    style: _pillButtonStyle(
                                      backgroundColor: AppColor.primaryColor
                                          .withValues(alpha: 0.06),
                                      borderColor: AppColor.primaryColor,
                                    ),
                                    child: Text(
                                      "LOGIN_AS_GUEST".tr,
                                      style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontFamily: 'Rubik',
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          authController.loader
              ? Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white60,
                    child: const Center(child: LoaderCircle()),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
