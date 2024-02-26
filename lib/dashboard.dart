import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late Timer _timer;
  late String formattedDateTime;
  double needleValue  = 40;


  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }



  



  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        formattedDateTime = _getFormattedDateTime();
      });
    });
    formattedDateTime = _getFormattedDateTime();
  }

  String _getFormattedDateTime() {
    return DateFormat('hh:mm:ss a yyyy-MM-dd').format(DateTime.now());
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                      child: Image.asset(
                        'assets/ailogo.png', width: 130,
                        height: 90, // Set the height as needed
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    formattedDateTime,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {

              },
              child: Center(
                  child: SizedBox(
                    width: 250,
                    height: 250,
                    child: SfRadialGauge(
                      axes: [
                        RadialAxis(
                          maximum: 60,
                          ranges: <GaugeRange>[
                            GaugeRange(
                                startValue: -10,
                                endValue: 60,
                                startWidth: 0.1,
                                sizeUnit: GaugeSizeUnit.factor,
                                endWidth: 0.1,
                                gradient: const SweepGradient(stops: <double>[
                                  0.2,
                                  0.5,
                                  0.75
                                ], colors: <Color>[
                                  Colors.green,
                                  Colors.yellow,
                                  Colors.red
                                ])),
                          ],
                          pointers:  [
                            NeedlePointer(
                                value: needleValue,
                                needleColor: const Color.fromRGBO(27, 20, 62, 1),
                                tailStyle: const TailStyle(
                                    length: 0.18,
                                    width: 8,
                                    color: Color.fromRGBO(27, 20, 62, 1),
                                    lengthUnit: GaugeSizeUnit.factor),
                                needleLength: 0.68,
                                needleStartWidth: 1,
                                needleEndWidth: 8,
                                knobStyle: const KnobStyle(
                                    knobRadius: 0.07,
                                    color: Colors.white,
                                    borderWidth: 0.05,
                                    borderColor: Color.fromRGBO(3, 67, 1, 1)),
                                lengthUnit: GaugeSizeUnit.factor)
                          ],
                          annotations: const <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Text(
                                  '°C',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(27, 20, 62, 1)),
                                ),
                                positionFactor: 0.8,
                                angle: 90)
                          ],
                        )
                      ],
                    ),
                  )),
            ),


            Center(
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: SfRadialGauge(
                    axes: [
                      RadialAxis(
                        maximum: 120,
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startValue: -20,
                              endValue: 130,
                              startWidth: 0.1,
                              sizeUnit: GaugeSizeUnit.factor,
                              endWidth: 0.1,
                              gradient: const SweepGradient(stops: <double>[
                                0.12,
                                0.15,
                                0.25,
                                0.85
                              ], colors: <Color>[
                                Color.fromRGBO(65, 107, 223, 0.1),
                                Color.fromRGBO(65, 107, 223, 0.2),
                                Color.fromRGBO(65, 107, 223, 0.3),
                                Color.fromRGBO(65, 107, 223, 1),


                              ])),
                        ],
                        pointers: const [
                          NeedlePointer(
                              value: 60,
                              needleColor: Color.fromRGBO(27, 20, 62, 1),
                              tailStyle: TailStyle(
                                  length: 0.18,
                                  width: 8,
                                  color: Color.fromRGBO(27, 20, 62, 1),
                                  lengthUnit: GaugeSizeUnit.factor),
                              needleLength: 0.68,
                              needleStartWidth: 1,
                              needleEndWidth: 8,
                              knobStyle: KnobStyle(
                                  knobRadius: 0.07,
                                  color: Colors.white,
                                  borderWidth: 0.05,
                                  borderColor: Color.fromRGBO(3, 67, 1, 1)),
                              lengthUnit: GaugeSizeUnit.factor)
                        ],
                        annotations: const <GaugeAnnotation>[
                          GaugeAnnotation(
                              widget: Text(
                                'Humidity',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(27, 20, 62, 1)),
                              ),
                              positionFactor: 0.8,
                              angle: 90)
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}