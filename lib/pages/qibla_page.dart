import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qibla_direction/qibla_direction.dart';
import 'dart:math' as math;

import '../services/prayer_times_service.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  _QiblaPageState createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  final _prayers = PrayerTimesService();
  double? qiblaDir;
  bool _hasPermissions = false;

  getQiblaDir() async {
    try {
      final pos = await _prayers.getCurrentLocation();
      final cord = _prayers.getCord(pos);
      //final cord = Coordinate(21.5194682, -0.1360365);

      setState(() {
        qiblaDir = QiblaDirection.find(cord);
      });
    } catch (e) {
      return Exception(e.toString());
    }
  }

  getPermissions() {
    Permission.locationWhenInUse.status.then((value) {
      if (mounted) {
        setState(() => _hasPermissions = (value == PermissionStatus.granted));
      }
    });
  }

  @override
  void initState() {
    getPermissions();
    getQiblaDir();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (_hasPermissions) {
          return _buildCompass();
        } else {
          return _buildPermission();
        }
      },
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        double? dir = snapshot.data!.heading;

        if (dir == null) {
          return Text("your device does not support compass");
        }

        return Center(
          child: Column(
            children: [
              Transform.rotate(
                angle: dir * (math.pi / 180) * -1,
                child: Image.asset(
                  "lib/assets/image/indicator.png",
                ),
              ),
              Transform.rotate(
                angle: (dir * (math.pi / 180) * -1) - (qiblaDir ?? 0),
                child: Image.asset(
                  "lib/assets/image/indicator.png",
                ),
              ),
              Transform.rotate(
                angle: (qiblaDir ?? 0),
                child: Image.asset(
                  "lib/assets/image/indicator.png",
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildPermission() {
    return Center(
      child: ElevatedButton(
        child: const Text('Request Permissions'),
        onPressed: () {
          Permission.locationWhenInUse.request().then((value) {
            getPermissions();
          });
        },
      ),
    );
  }
}
