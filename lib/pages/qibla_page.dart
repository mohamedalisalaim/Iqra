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

        // double adjustedHeading = direction - qiblaDir;
        // adjustedHeading = (adjustedHeading + 360) % 360;

        return SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset("lib/assets/images/compass.png"),
              Transform.rotate(
                angle: (direction - qiblaDir) * (3.141592653589793 / 180),
                child: Image.asset("lib/assets/images/indicator.png"),
              )
            ],
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
