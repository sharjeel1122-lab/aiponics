import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class HVAC extends StatefulWidget {
  const HVAC({super.key});

  @override
  State<HVAC> createState() => _HAVCState();
}

class _HAVCState extends State<HVAC> {

  bool isMessage1 = true;
  bool isMessage2 = true;
  bool isMessage3 = true;
  bool isMessage4 = true;
  bool isMessage5 = true;
  bool isMessage6 = true;
  bool isMessage7 = true;
  bool isMessage8 = true;
  bool isMessage9 = true;
  bool isMessage10 = true;
  bool isMessage11 = true;
  bool isMessage12 = true;
  bool isMessage13 = true;
  bool isMessage14 = true;
  bool isMessage15 = true;
  bool isMessage16 = true;
  bool mpump = true;
  bool spump = true;
  bool isSwitched = false;



  @override
  void initState() {
    super.initState();
    _loadButtonState();
    _saveButtonState();


  }

  _loadButtonState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mpump = prefs.getBool('mpump') ?? true;
      spump = prefs.getBool('spump') ?? true;
      isMessage1 = prefs.getBool('isMessage1') ?? true;
      isMessage2 = prefs.getBool('isMessage2') ?? true;
      isMessage3 = prefs.getBool('isMessage3') ?? true;
      isMessage4 = prefs.getBool('isMessage4') ?? true;
      isMessage5 = prefs.getBool('isMessage5') ?? true;
      isMessage6 = prefs.getBool('isMessage6') ?? true;
      isMessage7 = prefs.getBool('isMessage7') ?? true;
      isMessage8 = prefs.getBool('isMessage8') ?? true;
      isMessage9 = prefs.getBool('isMessage9') ?? true;
      isMessage10 = prefs.getBool('isMessage10') ?? true;
      isMessage11 = prefs.getBool('isMessage11') ?? true;
      isMessage12 = prefs.getBool('isMessage12') ?? true;
      isMessage13 = prefs.getBool('isMessage13') ?? true;
      isMessage14 = prefs.getBool('isMessage14') ?? true;
      isMessage15 = prefs.getBool('isMessage15') ?? true;
      isMessage16 = prefs.getBool('isMessage16') ?? true;
      isSwitched = prefs.getBool('isSwitched') ?? true;


      // Load other button states similarly
    });
  }
  _saveButtonState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('mpump', mpump);
    await prefs.setBool('spump', spump);
    await prefs.setBool('isMessage1', isMessage1);
    await prefs.setBool('isMessage2', isMessage2);
    await prefs.setBool('isMessage3', isMessage3);
    await prefs.setBool('isMessage4', isMessage4);
    await prefs.setBool('isMessage5', isMessage5);
    await prefs.setBool('isMessage6', isMessage6);
    await prefs.setBool('isMessage7', isMessage7);
    await prefs.setBool('isMessage8', isMessage8);
    await prefs.setBool('isMessage9', isMessage9);
    await prefs.setBool('isMessage10', isMessage10);
    await prefs.setBool('isMessage11', isMessage11);
    await prefs.setBool('isMessage12', isMessage12);
    await prefs.setBool('isMessage13', isMessage13);
    await prefs.setBool('isMessage14', isMessage14);
    await prefs.setBool('isMessage15', isMessage15);
    await prefs.setBool('isMessage16', isMessage16);
    await prefs.setBool('isSwitched', isSwitched);





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
          bottom: 60.0, // Adjust position as needed
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1,
          child: Material(
            color: Colors.transparent,
            child:Container(
                margin: const EdgeInsets.only(right: 15),
                width: 20,
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromRGBO(3, 67, 1, 0.7)
                ),
                child:  Center(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),
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
     //Conversion Function
  String binaryToHex(String binary) {
    // Ensure that the binary string length is a multiple of 4
    while (binary.length % 4 != 0) {
      binary = '0$binary';
    }
    // Convert binary to decimal
    int decimal = int.parse(binary, radix: 2);
    // Convert decimal to hexadecimal
    String hex = decimal.toRadixString(16).toUpperCase();
    return hex;
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Image.asset('assets/ailogo.png',width: 110,height: 75,),
                const SizedBox(
                  width: 128,
                ),
                const Text('Manual',style: TextStyle(fontWeight: FontWeight.w500),),
                SizedBox(
                  width: 70,
                  child: Transform.scale(
                    scale: 1.0,
                    child: Switch(
                      activeColor: const Color.fromRGBO(3, 67, 1, 1),
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          _saveButtonState(); // Save the button state


                        });
                      },
                    ),
                  ),
                ),
                const Text('Auto',style: TextStyle(fontWeight: FontWeight.w500)),

              ],
            ),
            const SizedBox(height: 5,),

            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              color: Colors.white60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 135,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (mpump) {
                            String mp=  binaryToHex('1000');
                            mqttClientWrapper.publish('admin2/controlpanel', '12$mp');
                            showToast(context, 'Main Pump On', const Duration(seconds: 1));
                          } else {
                            String mp=  binaryToHex('0111');
                            mqttClientWrapper.publish('admin2/controlpanel', '12$mp');
                            showToast(context, 'Main Pump Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            mpump = !mpump;
                            _saveButtonState(); // Save the button state
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          backgroundColor:
                          isSwitched
                              ? Colors.grey:
                          mpump ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9),
                        ),
                        child: Text('Main Pump ${mpump ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 135,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () async {

                          if (spump) {
                            String sp=  binaryToHex('0100');
                            mqttClientWrapper.publish('admin2/controlpanel', '12$sp');
                            showToast(context, 'Small Pump On', const Duration(seconds: 1));

                          } else {
                            String sp=  binaryToHex('1011');
                            mqttClientWrapper.publish('admin2/controlpanel', '12$sp');
                            showToast(context, 'Small Pump Off', const Duration(seconds: 1));

                          }
                          setState(() {
                            spump = !spump;
                            _saveButtonState();

                            // Save the button state
                          });

                        },
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          backgroundColor:      isSwitched
                              ? Colors.grey:spump ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9),
                        ),
                        child: Text('Small Pump ${spump ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),




                ],
              ),
            ),
            const SizedBox(height: 45,),


            Container(
              margin: const EdgeInsets.only(left: 7, right: 7),
              color: Colors.white60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (isMessage1) {
                            String f1=  binaryToHex('1000000000000000');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f1');
                            showToast(context, 'Fan On', const Duration(seconds: 1));

                          } else {
                            String f1=  binaryToHex('0111111111111111');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f1');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));

                          }
                          setState(() {
                            isMessage1 = !isMessage1;
                            _saveButtonState();

                            // Save the button state
                          });

                        },
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          backgroundColor:     isSwitched
                              ? Colors.grey: isMessage1 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9),
                        ),
                        child: Text('F1 ${isMessage1 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),


                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (isMessage2) {
                            String f2=  binaryToHex('0100000000000000');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f2');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f2=  binaryToHex('1011111111111111');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f2');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage2 = !isMessage2;
                            _saveButtonState();// Toggle the message flag
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                            isSwitched
                                ? Colors.grey:
                            isMessage2 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F2 ${isMessage2 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isMessage3) {
                            String f3=  binaryToHex('0010000000000000');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f3');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f3=  binaryToHex('1101111111111111');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f3');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage3 = !isMessage3; // Toggle the message flag
                            _saveButtonState();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                            isSwitched
                                ? Colors.grey:
                            isMessage3 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F3 ${isMessage3 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isMessage4) {
                            String f4=  binaryToHex('0001000000000000');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f4');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f4=  binaryToHex('1110111111111111');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f4');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage4 = !isMessage4; // Toggle the message flag
                            _saveButtonState();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                            isSwitched
                                ? Colors.grey:
                            isMessage4 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F4 ${isMessage4 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 2, right: 2),
              color: Colors.white60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isMessage5) {
                            String f5=  binaryToHex('0000100000000000');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f5');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f5=  binaryToHex('1111011111111111');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f5');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage5 = !isMessage5; // Toggle the message flag
                            _saveButtonState();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                            isSwitched
                                ? Colors.grey:
                            isMessage5 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F5 ${isMessage5 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isMessage6) {
                            String f6=  binaryToHex('0000010000000000');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f6');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f6=  binaryToHex('1111101111111111');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f6');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage6 = !isMessage6; // Toggle the message flag
                            _saveButtonState();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                            isSwitched
                                ? Colors.grey:
                            isMessage6 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F6 ${isMessage6 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isMessage7) {
                            String f7=  binaryToHex('0000001000000000');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f7');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f7=  binaryToHex('1111110111111111');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f7');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage7 = !isMessage7; // Toggle the message flag
                            _saveButtonState();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                            isSwitched
                                ? Colors.grey:
                            isMessage7 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F7 ${isMessage7 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isMessage8) {
                            String f8=  binaryToHex('0000000100000000');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f8');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f8=  binaryToHex('1111111011111111');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f8');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage8 = !isMessage8; // Toggle the message flag
                            _saveButtonState();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:     isSwitched
                                ? Colors.grey:
                            isMessage8 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F8 ${isMessage8 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.only(left: 7, right: 7),
              color: Colors.white60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isMessage9) {
                            String f9=  binaryToHex('0000000010000000');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f9');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f9=  binaryToHex('1111111101111111');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f9');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage9 = !isMessage9; // Toggle the message flag
                            _saveButtonState();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                            isSwitched
                                ? Colors.grey:
                            isMessage9 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F9 ${isMessage9 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isMessage10) {
                            String f10=  binaryToHex('0000000001000000');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f10');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f10=  binaryToHex('1111111110111111');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f10');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage10 = !isMessage10; // Toggle the message flag
                            _saveButtonState();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                            isSwitched
                                ? Colors.grey:
                            isMessage10 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F10 ${isMessage10 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isMessage11) {
                            String f11=  binaryToHex('0000000000100000');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f11');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f11=  binaryToHex('1111111111011111');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f11');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage11 = !isMessage11; // Toggle the message flag
                            _saveButtonState();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                            isSwitched
                                ? Colors.grey:
                            isMessage11 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F11 ${isMessage11 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isMessage12) {
                            String f12=  binaryToHex('0000000000010000');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f12');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f12=  binaryToHex('1111111111101111');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f12');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage12 = !isMessage12; // Toggle the message flag
                            _saveButtonState();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                            isSwitched
                                ? Colors.grey:
                            isMessage12 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F12 ${isMessage12 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 2, right: 2),
              color: Colors.white60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isMessage13) {
                            String f13=  binaryToHex('0000000000001000');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f13');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f13=  binaryToHex('1111111111110111');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f13');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage13 = !isMessage13; // Toggle the message flag
                            _saveButtonState();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                            isSwitched
                                ? Colors.grey:
                            isMessage13 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F13 ${isMessage13 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isMessage14) {
                            String f14=  binaryToHex('0000000000000100');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f14');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f14=  binaryToHex('1111111111111011');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f14');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage14 = !isMessage14; // Toggle the message flag
                            _saveButtonState();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                            isSwitched
                                ? Colors.grey:
                            isMessage14 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F14 ${isMessage14 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isMessage15) {
                            String f15=  binaryToHex('0000000000000010');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f15');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f15=  binaryToHex('1111111111111101');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f15');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage15 = !isMessage15; // Toggle the message flag
                            _saveButtonState();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                            isSwitched
                                ? Colors.grey:
                            isMessage15 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F15 ${isMessage15 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: 95,
                    height: 60,
                    child: IgnorePointer(
                      ignoring: isSwitched,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isMessage16) {
                            String f16=  binaryToHex('0000000000000001');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f16');
                            showToast(context, 'Fan On', const Duration(seconds: 1));
                          } else {
                            String f16=  binaryToHex('1111111111111110');
                            mqttClientWrapper.publish('admin2/controlpanel', '11$f16');
                            showToast(context, 'Fan Off', const Duration(seconds: 1));
                          }
                          setState(() {
                            isMessage16 = !isMessage16; // Toggle the message flag
                            _saveButtonState();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor:
                            isSwitched
                                ? Colors.grey:
                            isMessage16 ? Colors.red : const Color.fromRGBO(3, 67, 1, 0.9)),
                        child: Text('F16 ${isMessage16 ? 'Off' : 'On'}', style: const TextStyle(color: Colors.white,fontSize: 12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 200,
              height: 70,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(3, 67, 1, 0.8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    if (!mqttClientWrapper.isConnected) {
                      mqttClientWrapper.connect();
                    } else {
                      showToast(context, 'Already Connected', const Duration(seconds: 1));
                    }
                  },
                  child: const Text('Reconnect',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400))),
            )
          ]),
        ));
  }
}




















