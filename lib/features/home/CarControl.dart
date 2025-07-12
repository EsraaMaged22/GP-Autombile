import 'dart:async';
import 'package:autombile/core/widgets/gradientText.dart';
import 'package:autombile/features/home/widgets/carControlshape.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../core/constants/colors.dart';

class CarControl extends StatefulWidget {
  const CarControl({super.key});

  @override
  State<CarControl> createState() => _CarControlState();
}

class _CarControlState extends State<CarControl> {
  final supabase = Supabase.instance.client;

  double? detectedSpeedLimit;
  double? vehicleSpeed;
  String? locationDescription;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchLatestDetection();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      fetchLatestDetection();
    });
  }

  Future<void> fetchLatestDetection() async {
    final response = await supabase
        .from('detections')
        .select()
        .order('created_at', ascending: false)
        .limit(1)
        .maybeSingle();

    if (response != null) {
      setState(() {
        detectedSpeedLimit = (response['detected_speed_limit'] as int?)?.toDouble();
        vehicleSpeed = response['vehicle_speed_at_detection'] as double?;
        final x = response['location_x'];
        final y = response['location_y'];
        final z = response['location_z'];
        locationDescription = "Location: ($x, $y, $z)";
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff9f9f9),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [  Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Center(child: Text('Control')),
          ),
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/notification.png', width: 30),
            ),

          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: vehicleSpeed != null
                ? SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 200,
                  interval: 20,
                  showTicks: true,
                  showLabels: true,
                  axisLineStyle: AxisLineStyle(
                    thickness: 0.15,
                    thicknessUnit: GaugeSizeUnit.factor,
                    cornerStyle: CornerStyle.bothFlat,
                    gradient: SweepGradient(
                      colors: <Color>[
                        Colors.green,
                        Colors.green,
                        Colors.orange,
                        Colors.red
                      ],
                      stops: <double>[0.3, 0.6, 0.8, 1],
                    ),
                  ),
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: vehicleSpeed!,
                      needleColor: Colors.black,
                      knobStyle: KnobStyle(color: Colors.black),
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        '${vehicleSpeed?.toInt() ?? 0} KM/HR',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      angle: 90,
                      positionFactor: 0.8,
                    )
                  ],
                )
              ],
            )
                : Center(child: CircularProgressIndicator()),
          ),
          Stack(
            children: [
              InvertedWaveHeader(height: 300, color: Color(0xFFF2F2F5)),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/icons/location.png', width: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 5, right: 110),
                          child: Text(
                            ' My Location',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'Mansoura,Dakahlia',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            'Speed Limit',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GradientText(
                            '${detectedSpeedLimit?.toInt() ?? 'N/A'} KM/H',
                            style: TextStyle(fontFamily: 'Digital7Italic', fontSize: 18),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF196bbe),
                                AppColor.primaryBlue,
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Description:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      locationDescription ?? 'No location data',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
