import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:restart_app/restart_app.dart';
import 'package:weather/home/home.dart';
import 'package:weather/service/location_service.dart';
import 'package:weather/service/permissions_service.dart';
import 'package:permission_handler/permission_handler.dart';

// flutter upgrade
// flutter run --release

class SplashPage extends StatefulWidget { 
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool? result;

  @override
  void initState() {
    super.initState();

    PermissionsService().askPermission(Permission.location).then(
      (value) {
        result = value;
        if (result == true) {
          getUserPosition();
        } else {
          openAppSettings();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/earth.png",
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  void getUserPosition() async {
    LocationService().getUserPosition().then((value) {
      if (value != null) {
        goToHome(value);
      } else {
        showWarningDialog();
      }
    });
  }

  void goToHome(Position value) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Home(lat: value.latitude, lon: value.longitude),
      ),
    );
  }

  void showWarningDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, _, __) => Center(
        child: Container(
          margin: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Warning"),
                        const Text("Please enable GPS to continue then click on confirm"),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Restart.restartApp();
                              },
                              child: const Text("Confirm"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
