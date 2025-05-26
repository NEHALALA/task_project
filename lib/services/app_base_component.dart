import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppBaseComponent {
  AppBaseComponent._privateConstructor();
  static final AppBaseComponent instance = AppBaseComponent._privateConstructor();

  final _loadingController = Get.put(LoadingController());
  final _connectivityController = Get.put(ConnectivityController());

  // Loading State Management
  void showLoading() {
    _loadingController.showLoading();
  }

  void hideLoading() {
    _loadingController.hideLoading();
  }

  // Network State Management
  Stream<ConnectivityResult> get connectivityStream => _connectivityController.connectivityStream;
  bool get isConnected => _connectivityController.isConnected.value;

  // Global Loading Overlay
  Widget buildLoadingOverlay() {
    return Obx(() {
      if (_loadingController.isLoading.value) {
        return Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 50,
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }

  // Network Status Widget
  Widget buildNetworkStatusWidget() {
    return Obx(() {
      if (!_connectivityController.isConnected.value) {
        return Container(
          color: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Center(
            child: Text(
              'No Internet Connection',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

class LoadingController extends GetxController {
  final RxBool isLoading = false.obs;

  void showLoading() {
    isLoading.value = true;
  }

  void hideLoading() {
    isLoading.value = false;
  }
}

class ConnectivityController extends GetxController {
  final RxBool isConnected = true.obs;
  final _connectivity = Connectivity();

  Stream<ConnectivityResult> get connectivityStream => 
      _connectivity.onConnectivityChanged.map((results) => results.first);

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    _connectivity.onConnectivityChanged.listen((results) => _updateConnectionStatus(results.first));
  }

  Future<void> _initConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _updateConnectionStatus(results.first);
    } catch (e) {
      debugPrint('Error checking connectivity: $e');
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    isConnected.value = result != ConnectivityResult.none;
  }
} 