import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_project/config/models/user_info/user_info_model.dart';
import 'package:task_project/services/local_storage.dart';

class AuthService extends GetxService {
  static AuthService? _instance;

  static AuthService get instance {
    _instance ??= Get.put(AuthService(), permanent: true);
    return _instance!;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _box = GetStorage();

  final _isLoggedIn = false.obs;
  final Rx<UserInfoModel> _userInfo = UserInfoModel.empty().obs;

  bool get isLoggedIn => _isLoggedIn.value;
  UserInfoModel get userInfo => _userInfo.value;

  @override
  void onInit() {
    super.onInit();
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      _isLoggedIn.value = true;
      retrieveInfo(currentUser.uid);
    } else if (_box.hasData('userId')) {
      _isLoggedIn.value = true;
      retrieveInfo(_box.read('userId'));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) throw Exception("User is null after login");

      await LocalStorage.instance.write('userId', user.uid);
      _isLoggedIn.value = true;

      await retrieveInfo(user.uid);
    } on FirebaseAuthException catch (e) {
      throw Exception(
        e.code == 'invalid-credential'
            ? 'Invalid email or password.'
            : 'Login failed: ${e.message}',
      );
    } catch (e, stackTrace) {
      debugPrint("Login error: $e");
      debugPrintStack(stackTrace: stackTrace);
      throw Exception('Unexpected error during login: $e');
    }
  }

  Future<void> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user?.uid;
      if (uid == null) throw Exception("User is null after registration");

      final newUser = UserInfoModel(
        uid: uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
      );

      await _firestore.collection('users').doc(uid).set(newUser.toJson());
      _userInfo.value = newUser;
      _isLoggedIn.value = true;
      await LocalStorage.instance.write('userId', uid);
    } on FirebaseAuthException catch (e) {
      throw Exception(
        e.code == 'email-already-in-use'
            ? 'This email is already registered.'
            : 'Registration failed: ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error during registration: $e');
    }
  }

  Future<void> retrieveInfo(String uid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();

      final data = userDoc.data();
      if (userDoc.exists && data != null && data is Map<String, dynamic>) {
        _userInfo.value = UserInfoModel.fromJson(data);
      } else {
        throw Exception("User document is missing or has wrong format.");
      }
    } catch (e, stackTrace) {
      debugPrint("retrieveInfo error: $e");
      debugPrintStack(stackTrace: stackTrace);
      throw Exception("Failed to retrieve user info: $e");
    }
  }

  Future<void> updateUserInfoModel(UserInfoModel updatedInfo) async {
    try {
      await _firestore
          .collection('users')
          .doc(updatedInfo.uid)
          .update(updatedInfo.toJson());

      _userInfo.value = updatedInfo;
    } catch (e) {
      throw Exception("Failed to update user info: $e");
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _isLoggedIn.value = false;
    _userInfo.value = UserInfoModel.empty();
    await _box.remove('userId');
  }
}
