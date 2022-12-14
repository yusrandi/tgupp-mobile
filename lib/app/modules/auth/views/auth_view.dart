import 'dart:ui';

import 'package:emeeting_flutter/app/cores/core_images.dart';
import 'package:emeeting_flutter/app/cores/core_strings.dart';
import 'package:emeeting_flutter/app/modules/base/views/base_view.dart';
import 'package:emeeting_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../cores/core_colors.dart';
import '../../../cores/core_constants.dart';
import '../../../cores/core_styles.dart';
import '../../../cores/helper/keyboard.dart';
import '../controllers/auth_controller.dart';
import '../controllers/authentication_manager.dart';

class AuthView extends GetView<AuthController> {
  AuthView({Key? key}) : super(key: key);

  final AuthController authController = Get.put(AuthController());
  final AuthenticationManager authenticationManager =
      Get.put(AuthenticationManager());

  final containerRadius = const Radius.circular(30.0);
  final _formKey = GlobalKey<FormState>();

  final _userEmail = TextEditingController();
  final _userPass = TextEditingController();

  String? validatePass(value) {
    if (value.isEmpty) {
      return kPassNullError;
    } else if (value.length < 8) {
      return kShortPassError;
    } else {
      return null;
    }
  }

  String? validateEmail(value) {
    if (value.isEmpty) {
      return kEmailNullError;
    } else if (!emailValidatorRegExp.hasMatch(value)) {
      return kInvalidEmailError;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    authenticationManager.checkLoginStatus();

    return Scaffold(
      backgroundColor: CoreColor.primary,
      body: Obx(
        () => authenticationManager.isLogged.value ? BaseView() : body(context),
      ),
    );
  }

  body(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    CoreImages.logoSulselImages,
                    height: 150,
                  )),
              Text(CoreStrings.appName,
                  style: CoreStyles.uTitle.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w800))
            ],
          ),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: containerRadius, topRight: containerRadius)),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: containerRadius, topRight: containerRadius)),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome Back",
                        style: CoreStyles.uTitle,
                      ),
                      Text(
                        "Sign in with your Email and password  \nto continue",
                        textAlign: TextAlign.center,
                        style: CoreStyles.uSubTitle,
                      ),
                      const SizedBox(height: (26)),
                      emailField(),
                      const SizedBox(height: (16)),
                      passwordField(),
                      const SizedBox(height: (36)),
                      GestureDetector(
                        onTap: () async {
                          // Get.offAndToNamed(Routes.BASE);
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            var email = _userEmail.text.trim();
                            var password = _userPass.text.trim();

                            print(email);
                            await authController.loginUser(email, password);
                            // ignore: use_build_context_synchronously
                            KeyboardUtil.hideKeyboard(context);
                          }
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: CoreColor.primary,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Obx(
                            () => authController.status.value == Status.running
                                ? loading()
                                : Text(
                                    "Login",
                                    style: CoreStyles.uSubTitle
                                        .copyWith(color: Colors.white),
                                  ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )),
      ],
    );
  }

  loading() {
    return CircularProgressIndicator(color: Colors.white);
  }

  TextFormField emailField() {
    return TextFormField(
      controller: _userEmail,
      validator: validateEmail,
      cursorColor: CoreColor.primary,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: CoreStyles.uSubTitle.copyWith(color: Colors.black),

        hintText: 'Enter your email address',
        // Here is key idea

        prefixIcon: Icon(Icons.mail_outlined, color: CoreColor.primary),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: CoreColor.primary, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: CoreColor.primaryExtraSoft,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: CoreColor.kHintTextColor,
            width: 1,
          ),
        ),
      ),
    );
  }

  passwordField() {
    return Obx(() => TextFormField(
          controller: _userPass,
          validator: validatePass,
          cursorColor: CoreColor.primary,
          keyboardType: TextInputType.text,
          obscureText: !authController
              .passwordVisible.value, //This will obscure text dynamically
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: CoreStyles.uSubTitle.copyWith(color: Colors.black),

            hintText: 'Enter your password',
            // Here is key idea
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                authController.passwordVisible.value
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: CoreColor.primary,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable

                authController.passwordVisible.value =
                    !authController.passwordVisible.value;
              },
            ),

            prefixIcon:
                Icon(Icons.lock_outline_rounded, color: CoreColor.primary),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: CoreColor.primary, width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: CoreColor.primaryExtraSoft,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: CoreColor.kHintTextColor,
                width: 1,
              ),
            ),
          ),
        ));
  }
}
