import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_project/config/theme/theme_controller.dart';
import 'package:task_project/gen/fonts.gen.dart';
import 'package:task_project/imports.dart';
import 'package:task_project/presentation/map/controller/map_controller.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

//class TaskView extends GetView<TaskController>
class MapView extends GetView<MapViewController> {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final themecontroller = ThemeController.instance;
    return Scaffold(
      appBar: AppBar(
        title: TextView(
          text: "Map Screen",
          fontFamily: FontFamily.calSans,
          fontSize: 24.sp,
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                // center: LatLng(
                //   controller.latitude.value,
                //   controller.longitude.value,
                // ),
                minZoom: 16.0,
                onTap: (tapPosition, point) {
                  controller.updateMarkerPosition(
                    point.latitude,
                    point.longitude,
                  );
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 50.0,
                      height: 50.0,
                      point: LatLng(
                        controller.latitude.value,
                        controller.longitude.value,
                      ),
                      child: const Icon(
                        Icons.location_pin,
                        size: 50,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              left: 15,
              right: 15,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      themecontroller.isDarkMode.value
                          ? AppColors.blackColor
                          : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: "Address",
                      fontFamily: FontFamily.calSans,
                      fontWeight: FontWeight.bold,
                    ),
                    Obx(
                      () => TextView(
                        text: controller.addressText.value,
                        fontFamily: FontFamily.calSans,
                      ),
                    ),

                    SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () => controller.saveAddressToFirebase(),
                      child: Text("Save Address"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 40),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
