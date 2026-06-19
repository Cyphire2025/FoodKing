// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../util/api-list.dart';
import '../../../../util/constant.dart';
import '../../../../widget/custom_snackbar.dart';
import '../../../data/api/server.dart';
import '../../../data/model/response/login_model.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../profile/controllers/profile_controller.dart';
import '../views/reset_password_view.dart';
import '../views/signup_view.dart';
import '../views/varify_otp_view.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final box = GetStorage();
  LoginModel loginModelData = LoginModel();
  Server server = Server();
  LoginModel loginModel = LoginModel();
  bool loader = false;
  List<Map<String, dynamic>> socialLoginProviders = [];
  bool _googleSignInInitialized = false;

  bool get hasGoogleLogin => socialLoginProviders.any(
    (provider) => provider['slug'] == 'google' && provider['status'] == 5,
  );

  @override
  void onInit() {
    if (box.read('isLogedIn') == null) {
      box.write('isLogedIn', false);
    } else if (box.read('isLogedIn') == true) {
      getRefreshToken();
    }
    if (box.read('viewValue') == null) {
      box.write('viewValue', 0);
    }
    getSocialLoginProviders();
    super.onInit();
  }

  Future<void> getSocialLoginProviders() async {
    try {
      final response = await server.getRequestWithoutToken(
        endPoint: APIList.socialLoginProviders,
      );
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final data = jsonResponse["data"];
        if (data is List) {
          socialLoginProviders = data
              .whereType<Map<String, dynamic>>()
              .where((provider) => provider['status'] == 5)
              .toList();
          update();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Map<String, dynamic>? socialProvider(String slug) {
    for (final provider in socialLoginProviders) {
      if (provider['slug'] == slug) {
        return provider;
      }
    }
    return null;
  }

  Future<String?> socialLoginUrl(String provider) async {
    loader = true;
    update();
    try {
      final response = await server.getRequestWithoutToken(
        endPoint: APIList.socialLoginUrl(provider),
      );
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse["url"]?.toString();
      }
      if (response != null) {
        final jsonResponse = json.decode(response.body);
        customSnackbar(
          "ERROR".tr,
          jsonResponse["errors"]?.toString() ?? "Unable to start Google login",
          AppColor.error,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      loader = false;
      update();
    }
    return null;
  }

  Future<void> _initializeGoogleSignIn() async {
    if (_googleSignInInitialized) {
      return;
    }

    if (socialLoginProviders.isEmpty) {
      await getSocialLoginProviders();
    }

    final googleProvider = socialProvider('google');
    final serverClientId = googleProvider?['client_id']?.toString();
    if (serverClientId == null || serverClientId.isEmpty) {
      throw const GoogleSignInException(
        code: GoogleSignInExceptionCode.providerConfigurationError,
        description:
            'Google client id is missing from admin social login settings.',
      );
    }

    await GoogleSignIn.instance.initialize(serverClientId: serverClientId);
    _googleSignInInitialized = true;
  }

  Future<LoginModel?> googleLogin() async {
    loader = true;
    update();

    try {
      await _initializeGoogleSignIn();
      final googleUser = await GoogleSignIn.instance.authenticate();
      final idToken = googleUser.authentication.idToken;

      if (idToken == null || idToken.isEmpty) {
        customSnackbar(
          "ERROR".tr,
          "Google login did not return an ID token",
          AppColor.error,
        );
        return null;
      }

      return verifyGoogleIdToken(idToken);
    } on GoogleSignInException catch (e) {
      customSnackbar(
        "ERROR".tr,
        e.description ?? "Google login failed",
        AppColor.error,
      );
    } catch (e) {
      debugPrint(e.toString());
      customSnackbar("ERROR".tr, "Google login failed", AppColor.error);
    } finally {
      loader = false;
      update();
    }

    return null;
  }

  Future<LoginModel?> verifyGoogleIdToken(String idToken) async {
    final jsonBody = json.encode({'id_token': idToken});
    try {
      final response = await server.postRequest(
        endPoint: APIList.socialLoginMobile('google'),
        body: jsonBody,
      );
      if (response != null && response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        loginModel = LoginModel.fromJson(jsonResponse);
        box.write('isLogedIn', true);
        final bearerToken = 'Bearer ${loginModel.token}';
        box.write('justToken', loginModel.token);
        box.write('token', bearerToken);
        Server.initClass(token: box.read('token'));
        Get.find<ProfileController>().getProfileData();
        customSnackbar(
          "SUCCESS".tr,
          jsonResponse["message"].toString(),
          AppColor.success,
        );
        Get.offAll(() => DashboardView());
        return loginModel;
      }
      if (response != null) {
        final jsonResponse = json.decode(response.body);
        customSnackbar(
          "ERROR".tr,
          jsonResponse["errors"]?.toString() ??
              jsonResponse["message"]?.toString() ??
              "Google login failed",
          AppColor.error,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<LoginModel?> verifySocialLogin(String provider, String code) async {
    loader = true;
    update();
    final jsonBody = json.encode({'code': code});
    try {
      final response = await server.postRequest(
        endPoint: APIList.socialLoginVerify(provider),
        body: jsonBody,
      );
      if (response != null && response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        loginModel = LoginModel.fromJson(jsonResponse);
        box.write('isLogedIn', true);
        final bearerToken = 'Bearer ${loginModel.token}';
        box.write('justToken', loginModel.token);
        box.write('token', bearerToken);
        Server.initClass(token: box.read('token'));
        Get.find<ProfileController>().getProfileData();
        customSnackbar(
          "SUCCESS".tr,
          jsonResponse["message"].toString(),
          AppColor.success,
        );
        Get.offAll(() => DashboardView());
        return loginModel;
      }
      if (response != null) {
        final jsonResponse = json.decode(response.body);
        customSnackbar(
          "ERROR".tr,
          jsonResponse["errors"]?.toString() ??
              jsonResponse["message"]?.toString() ??
              "Google login failed",
          AppColor.error,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      loader = false;
      update();
    }
    return null;
  }

  Future<LoginModel?> login(email, password) async {
    loader = true;
    update();

    Map body = {'email': email, 'password': password};
    String jsonBody = json.encode(body);
    try {
      server.postRequest(endPoint: APIList.login, body: jsonBody).then((
        response,
      ) {
        if (response != null && response.statusCode == 201) {
          final jsonResponse = json.decode(response.body);
          loginModel = LoginModel.fromJson(jsonResponse);
          box.write('isLogedIn', true);
          var bearerToken =
              'Bearer '
              '${loginModel.token}';
          box.write('justToken', loginModel.token);
          box.write('token', bearerToken);
          box.write('email', email);
          box.write('password', password);
          Server.initClass(token: box.read('token'));
          Get.find<ProfileController>().getProfileData();
          update();
          customSnackbar(
            "SUCCESS".tr,
            jsonResponse["message"].toString(),
            AppColor.success,
          );
          update();
          Get.offAll(() => DashboardView());
          loader = false;
          update();
          return loginModel;
        } else {
          final jsonResponse = json.decode(response.body);

          box.write('isLogedIn', false);
          customSnackbar(
            "ERROR".tr,
            jsonResponse["errors"]["validation"].toString(),
            AppColor.error,
          );
          loader = false;
          update();

          return null;
        }
      });

      return loginModel;
    } catch (e) {
      return null;
    }
  }

  Future getRefreshToken() async {
    try {
      server
          .getRequest(endPoint: APIList.refreshToken! + box.read('justToken'))
          .then((response) {
            if (response != null && response.statusCode == 201) {
              final jsonResponse = json.decode(response.body);
              var bearerToken = 'Bearer ' + jsonResponse["token"].toString();
              box.write('token', bearerToken);
              update();
            } else {
              box.write('isLogedIn', false);
              box.remove('token');
              update();
            }
          });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future phoneNumberSignUp(phoneNumber) async {
    loader = true;
    update();
    Map body = {'phone': phoneNumber, 'code': box.read("countryCode")};
    String jsonBody = json.encode(body);
    try {
      server.postRequest(endPoint: APIList.otpSignUp, body: jsonBody).then((
        response,
      ) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          if (box.read("otpVarify") == 5) {
            customSnackbar(
              "SUCCESS".tr,
              jsonResponse["message"].toString(),
              AppColor.success,
            );
            Get.off(
              VeryfiyOtpView(
                phoneNumber: phoneNumber,
                isGuest: false,
                forgetPassword: false,
              ),
            );
          } else if (box.read("otpVarify") == 10) {
            Get.off(SignupView(phoneNumber: phoneNumber));
          }
          loader = false;
          update();
        } else {
          final jsonResponse = json.decode(response.body);
          customSnackbar(
            "ERROR".tr,
            jsonResponse["message"].toString(),
            AppColor.error,
          );
          loader = false;
          update();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future guestPhoneNumberSignUp(phoneNumber) async {
    loader = true;
    update();
    Map body = {'phone': phoneNumber, 'code': box.read("countryCode")};
    String jsonBody = json.encode(body);
    try {
      server.postRequest(endPoint: APIList.guestOtpSignUp, body: jsonBody).then(
        (response) {
          if (response != null && response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            if (box.read("otpVarify") == 5) {
              customSnackbar(
                "SUCCESS".tr,
                jsonResponse["message"].toString(),
                AppColor.success,
              );
              Get.off(
                VeryfiyOtpView(
                  phoneNumber: phoneNumber,
                  isGuest: true,
                  forgetPassword: false,
                ),
              );
              loader = false;
              update();
            } else if (box.read("otpVarify") == 10) {
              guestOtpVarify(phoneNumber, "0000");
              loader = false;
              update();
            }
          } else {
            //here
            loader = false;
            update();
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future otpVarify(phone, code) async {
    Map body = {'phone': phone, 'token': code, 'code': box.read("countryCode")};
    String jsonBody = json.encode(body);
    try {
      server.postRequest(endPoint: APIList.otpVarify, body: jsonBody).then((
        response,
      ) {
        if (response != null && response.statusCode == 201) {
          final jsonResponse = json.decode(response.body);
          customSnackbar(
            "SUCCESS".tr,
            jsonResponse["message"].toString(),
            AppColor.success,
          );
          Get.off(SignupView(phoneNumber: phone));
        } else {
          final jsonResponse = json.decode(response.body);
          customSnackbar("ERROR".tr, jsonResponse["message"], AppColor.error);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<LoginModel?> guestOtpVarify(phone, code) async {
    Map body = {'phone': phone, 'token': code, 'code': box.read("countryCode")};
    String jsonBody = json.encode(body);
    try {
      server.postRequest(endPoint: APIList.guestOtpVarify, body: jsonBody).then(
        (response) {
          if (response != null && response.statusCode == 201) {
            final jsonResponse = json.decode(response.body);
            loginModel = LoginModel.fromJson(jsonResponse);
            box.write('isLogedIn', true);
            // ignore: prefer_adjacent_string_concatenation
            var bearerToken = 'Bearer ' + '${loginModel.token}';
            box.write('token', bearerToken);
            Server.initClass(token: box.read('token'));
            Get.find<ProfileController>().getProfileData();
            update();
            customSnackbar(
              "SUCCESS".tr,
              jsonResponse["message"].toString(),
              AppColor.success,
            );
            update();
            Get.offAll(() => DashboardView());
            return loginModel;
          } else {
            final jsonResponse = json.decode(response.body);
            box.write('isLogedIn', false);
            customSnackbar("Error", jsonResponse["message"], AppColor.error);
            return null;
          }
        },
      );
      return loginModel;
    } catch (e) {
      return null;
    }
  }

  Future register(fName, lName, email, password, phone) async {
    loader = true;
    update();
    Map body = {
      'first_name': fName,
      'last_name': lName,
      'email': email,
      'phone': phone,
      'country_code': box.read("countryCode").toString(),
      'password': password,
    };
    String jsonBody = json.encode(body);
    try {
      server.postRequest(endPoint: APIList.register, body: jsonBody).then((
        response,
      ) {
        if (response != null && response.statusCode == 201) {
          final jsonResponse = json.decode(response.body);
          emailController.text = email;
          passwordController.text = password;
          login(email, password);
          loader = false;
          update();
        } else {
          final jsonResponse = json.decode(response.body);
          customSnackbar("ERROR".tr, jsonResponse["message"], AppColor.error);
          loader = false;
          update();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      loader = false;
      update();
    }
    loader = false;
    update();
  }

  Future forgetPassword(email) async {
    loader = true;
    update();
    Map body = {'email': email};
    String jsonBody = json.encode(body);
    try {
      server.postRequest(endPoint: APIList.forgetPassword, body: jsonBody).then(
        (response) {
          if (response != null && response.statusCode == 200) {
            customSnackbar(
              "OTP".tr,
              "OTP_SENT_PLEASE_CHECK".tr,
              AppColor.success,
            );
            final jsonResponse = json.decode(response.body);
            Get.off(
              VeryfiyOtpView(
                phoneNumber: email,
                isGuest: false,
                forgetPassword: true,
              ),
            );
            loader = false;
            update();
          } else {
            final jsonResponse = json.decode(response.body);
            customSnackbar(
              "ERROR".tr,
              jsonResponse["errors"]["email"][0].toString(),
              AppColor.error,
            );
            loader = false;
            update();
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future varifyEmail(email, code) async {
    loader = true;
    update();
    Map body = {'email': email, 'code': code};
    String jsonBody = json.encode(body);
    try {
      server
          .postRequest(
            endPoint: APIList.passwordResetVarifyCode,
            body: jsonBody,
          )
          .then((response) {
            if (response != null && response.statusCode == 200) {
              final jsonResponse = json.decode(response.body);
              Get.off(ResetPasswordView(email: email));
              loader = false;
              update();
            } else {
              final jsonResponse = json.decode(response.body);
              customSnackbar(
                "ERROR".tr,
                jsonResponse["errors"]["code"][0].toString(),
                AppColor.error,
              );
              loader = false;
              update();
            }
          });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future passwordReset(email, newPassword, confirmNewPassword) async {
    loader = true;
    update();
    Map body = {
      'email': email,
      'password': newPassword,
      'password_confirmation': confirmNewPassword,
    };
    String jsonBody = json.encode(body);
    try {
      server.postRequest(endPoint: APIList.passwordReset, body: jsonBody).then((
        response,
      ) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          customSnackbar(
            "SUCCESS".tr,
            jsonResponse["message"].toString(),
            AppColor.success,
          );
          loginAfterPasswordReset(email, newPassword, jsonResponse["token"]);
          loader = false;
          update();
        } else {
          final jsonResponse = json.decode(response.body);
          customSnackbar(
            "ERROR".tr,
            jsonResponse["errors"]["password"][0].toString(),
            AppColor.error,
          );
          loader = false;
          update();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future loginAfterPasswordReset(email, password, token) async {
    loader = true;
    update();
    Map body = {'email': email, 'password': password};
    String jsonBody = json.encode(body);
    try {
      server.postRequest(endPoint: APIList.login, body: jsonBody).then((
        response,
      ) {
        if (response != null && response.statusCode == 201) {
          loader = false;
          update();
          final jsonResponse = json.decode(response.body);
          box.write('isLogedIn', true);
          // ignore: prefer_adjacent_string_concatenation
          var bearerToken = 'Bearer ' + '$token';
          box.write('token', bearerToken);
          Server.initClass(token: box.read('token'));
          Get.find<ProfileController>().getProfileData();
          update();
          customSnackbar(
            "SUCCESS".tr,
            jsonResponse["message"].toString(),
            AppColor.success,
          );
          update();
          Get.offAll(() => DashboardView());
        } else {
          final jsonResponse = json.decode(response.body);
          loader = false;
          update();
          box.write('isLogedIn', false);
          customSnackbar(
            "ERROR".tr,
            jsonResponse["errors"]["validation"].toString(),
            AppColor.error,
          );
          update();
        }
      });
      loader = false;
    } catch (e) {
      loader = false;
      update();
      return null;
    }
  }

  Future postDeviceToken(token) async {
    loader = true;
    update();
    Map body = {'token': token};
    String jsonBody = json.encode(body);
    try {
      server.postRequestWithToken(endPoint: APIList.token, body: jsonBody).then(
        (response) {
          if (response != null && response.statusCode == 200) {
            print(response.body);
            loader = false;
            update();
          } else {
            loader = false;
            update();
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      loader = false;
      update();
    }
    loader = false;
    update();
  }
}
