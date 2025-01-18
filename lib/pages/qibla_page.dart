import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qibla_direction/qibla_direction.dart';
import '../services/prayer_times_service.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  _QiblaPageState createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  bool _hasPermission = false;
  double qiblaDir = 0;
  final _prayer = PrayerTimesService();

  @override
  void initState() {
    super.initState();
    _fetchPermission();
    _getQiblaDir();
  }

  void _getQiblaDir() async {
    try {
      final pos = await _prayer.getCurrentLocation();
      final cord = _prayer.getCord(pos);

      setState(() {
        qiblaDir = QiblaDirection.find(cord);
      });
    } catch (e) {
      return print(e.toString());
    }
  }

  void _fetchPermission() {
    Permission.locationWhenInUse.status.then((value) {
      if (mounted) {
        setState(() {
          _hasPermission = (value == PermissionStatus.granted);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (_hasPermission) {
          return _buildCompass();
        } else {
          return _buildPermissionSheet();
        }
      },
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        // wating
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        double? direction = snapshot.data!.heading;

        if (direction == null) {
          return const Center(
            child: Text("device deos not support compass"),
          );
        }

        return SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Transform.rotate(
                    angle: direction * (3.1415926535897932 / 180) * -1,
                    child: Image.asset("lib/images/indicator.png"),
                  ),
                  Transform.rotate(
                    angle: (direction * (3.1415926535897932 / 180) * -1) -
                        qiblaDir,
                    child: Image.asset("lib/images/indicator.png"),
                  ),
                  Transform.rotate(
                    angle: qiblaDir,
                    child: Image.asset("lib/images/indicator.png"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            Permission.locationWhenInUse.request().then((value) {
              _fetchPermission();
            });
          },
          child: const Text("Request Permission")),
    );
  }
}
