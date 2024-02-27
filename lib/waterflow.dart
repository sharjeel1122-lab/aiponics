import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class WaterFlow extends StatefulWidget {
  const WaterFlow({super.key});

  @override
  State<WaterFlow> createState() => _WaterFlowState();
}

class _WaterFlowState extends State<WaterFlow> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  bool isnft = true;
  bool isdft = true;
  bool tomato =true;

  @override
  void initState() {
    super.initState();
    _loadButtonState();
    _saveButtonState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  _loadButtonState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isnft = prefs.getBool('isnft') ?? true;
      isdft = prefs.getBool('isdft') ?? true;
      tomato = prefs.getBool('tomato') ?? true;

      // Load other button states similarly
    });
  }

  _saveButtonState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isnft', isnft);
    await prefs.setBool('isdft', isdft);
    await prefs.setBool('tomato',tomato);

    // Save other button states similarly
  }

  /* void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }*/

  void showToast(BuildContext context, String message, Duration duration) {
    OverlayEntry overlayEntry;

    // Create an OverlayEntry to show the toast message
    overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
              bottom: 130.0, // Adjust position as needed
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Material(
                color: Colors.transparent,
                child: Container(
                    margin: const EdgeInsets.only(right: 15),
                    width: 20,
                    height: 50,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromRGBO(3, 67, 1, 0.7)),
                    child: Center(
                      child: Text(
                        message,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    )
                    /* Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),
              ),
            ),
          ),*/
                    ),
              ),
            ));

    // Show the overlayEntry
    Overlay.of(context).insert(overlayEntry);

    // Delay for the specified duration before removing the toast
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Image.asset(
              'assets/ailogo.png',
              width: 240,
              height: 200,
            )),
            const Center(
                child: Text(
              '   Control Setup Pumps',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 23),
            )),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40, top: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('NFT Setup'),
                      SizedBox(
                        width: 66,
                        height: 62,
                        child: ElevatedButton(
                          onPressed: () {
                            if (isnft) {
                              mqttClientWrapper.publish(
                                  'FanControl', '11131000000');
                              showToast(
                                  context, 'On', const Duration(seconds: 1));
                            } else {
                              mqttClientWrapper.publish(
                                  'FanControl', '11130000000');
                              showToast(
                                  context, 'Off', const Duration(seconds: 1));
                            }
                            setState(() {
                              isnft = !isnft; // Toggle the message flag
                              _saveButtonState();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              backgroundColor: isnft
                                  ? Colors.red
                                  : const Color.fromRGBO(3, 67, 1, 0.9)),
                          child: Text(isnft ? 'Off' : 'On',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('DFT Setup'),
                      const Text('Set Min (1-59)'),
                      SizedBox(
                        width: 20,
                        child: TextField(
                          controller: _controller1,
                          maxLength: 2,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              hintText: '20',
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              int? number = int.tryParse(value);
                              if (number == null || number < 0 || number > 59) {
                                _controller1.text =
                                    value.substring(0, value.length - 1);
                                _controller1.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: _controller1.text.length));
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 66,
                        height: 62,
                        child: ElevatedButton(
                          onPressed: () {
                            if (isdft) {
                              mqttClientWrapper.publish(
                                  'FanControl', '11131000000');
                              showToast(
                                  context, 'On', const Duration(seconds: 1));
                            } else {
                              mqttClientWrapper.publish(
                                  'FanControl', '11130000000');
                              showToast(
                                  context, 'Off', const Duration(seconds: 1));
                            }
                            setState(() {
                              isdft = !isdft; // Toggle the message flag
                              _saveButtonState();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              backgroundColor: isdft
                                  ? Colors.red
                                  : const Color.fromRGBO(3, 67, 1, 0.9)),
                          child: Text(isdft ? 'Off' : 'On',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tomato'),
                      const Column(
                        children: [
                          Text('   Set Min (1-59)'),
                          SizedBox(height: 25,),
                          Text('    Set Freq (1-10)'),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 20,
                            child: TextField(
                              controller: _controller2,
                              maxLength: 2,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  hintText: '10',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black))),
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  int? number = int.tryParse(value);
                                  if (number == null || number < 0 || number > 59) {
                                    _controller2.text =
                                        value.substring(0, value.length - 1);
                                    _controller2.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: _controller2.text.length));
                                  }
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                            child: TextField(
                              controller: _controller3,
                              maxLength: 2,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  hintText: '03',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black))),
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  int? number = int.tryParse(value);
                                  if (number == null || number < 0 || number > 10) {
                                    _controller3.text =
                                        value.substring(0, value.length - 1);
                                    _controller3.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: _controller3.text.length));
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
        
                      SizedBox(
                        width: 66,
                        height: 62,
                        child: ElevatedButton(
                          onPressed: () {
                            if (tomato) {
                              mqttClientWrapper.publish(
                                  'FanControl', '11131000000');
                              showToast(
                                  context, 'On', const Duration(seconds: 1));
                            } else {
                              mqttClientWrapper.publish(
                                  'FanControl', '11130000000');
                              showToast(
                                  context, 'Off', const Duration(seconds: 1));
                            }
                            setState(() {
                              tomato= !tomato; // Toggle the message flag
                              _saveButtonState();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              backgroundColor: tomato
                                  ? Colors.red
                                  : const Color.fromRGBO(3, 67, 1, 0.9)),
                          child: Text(tomato ? 'Off' : 'On',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
