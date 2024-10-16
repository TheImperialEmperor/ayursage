import 'package:ayursage/src/repository/auth_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GettingStartedController extends GetxController{
  static GettingStartedController get instance=>Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  void registerUser(String email, String password){
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }
  void phoneAuthentication(String phoneNo){
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}