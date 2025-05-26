import 'package:task_project/config/models/address/address_model.dart';
import 'package:task_project/imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapViewController extends GetxController {
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString addressText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Get.snackbar("Permission Denied", "Location permission is required.");
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    latitude.value = position.latitude;
    longitude.value = position.longitude;

    await _updateAddressFromCoordinates();
  }

  Future<void> updateMarkerPosition(double lat, double lng) async {
    latitude.value = lat;
    longitude.value = lng;
    await _updateAddressFromCoordinates();
  }

  Future<void> _updateAddressFromCoordinates() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude.value,
      longitude.value,
    );

    if (placemarks.isNotEmpty) {
      final p = placemarks[0];
      addressText.value =
          "${p.name}, ${p.subLocality}, ${p.locality}, ${p.administrativeArea}, ${p.country} - ${p.postalCode}";
    }
  }

  Future<void> saveAddressToFirebase() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        Get.snackbar("Error", "No user logged in");
        return;
      }

      final placemarks = await placemarkFromCoordinates(
        latitude.value,
        longitude.value,
      );

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final address = AddressModel(
          line1: p.name ?? '',
          line2: p.subLocality ?? '',
          area: p.subAdministrativeArea ?? '',
          city: p.locality ?? '',
          state: p.administrativeArea ?? '',
          country: p.country ?? '',
          zip: p.postalCode ?? '',
          latitude: latitude.value,
          longitude: longitude.value,
        );

        print("Saving address: ${address.toJson()}");

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('addresses')
            .add(address.toJson());

        Get.snackbar("Success", "Address saved successfully");
      } else {
        Get.snackbar("Error", "Could not resolve address");
      }
    } catch (e) {
      print("Save address error: $e");
      Get.snackbar("Error", "Failed to save address: $e");
    }
  }
}
