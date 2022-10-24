import 'package:emeeting_flutter/app/cores/core_colors.dart';
import 'package:emeeting_flutter/app/data/models/user_model.dart';
import 'package:emeeting_flutter/app/modules/auth/controllers/authentication_manager.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../configs/api.dart';
import '../../../cores/core_images.dart';
import '../../../cores/core_styles.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  final ProfileController profileController = Get.put(ProfileController());
  final AuthenticationManager authenticationManager =
      Get.put(AuthenticationManager());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: false,
        backgroundColor: CoreColor.primary,
      ),
      body: Center(
          child: FutureBuilder<UserModel>(
        future: profileController.profileUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          UserModel data = snapshot.data!;

          return profilePage(data, context);
        },
      )),
    );
  }

  profilePage(UserModel model, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(100), // Image radius
                child: Image.network(Api.imageURL + model.image!,
                    fit: BoxFit.cover),
              ),
            ),
            Text(
              '${model.fullname!}  ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              model.email!,
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              model.title!.name!,
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                authenticationManager.logOut();
                Get.offAllNamed(Routes.AUTH);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: CoreColor.primary),
                child: Center(
                  child: Text(
                    'Keluar',
                    style: Theme.of(context).primaryTextTheme.titleLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
