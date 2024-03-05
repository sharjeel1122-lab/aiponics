import 'package:aiponics/about.dart';
import 'package:aiponics/dashboard.dart';
import 'package:aiponics/hvac.dart';
import 'package:aiponics/mqtt_service.dart';
import 'package:aiponics/waterflow.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

MqttClientWrapper mqttClientWrapper = MqttClientWrapper();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isConnected = false;
  bool isConnecting = false;



  @override
  void initState() {
    super.initState();
    _checkInternetAndConnect();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          _isConnected = false;
        });
      } else {
        _checkInternetAndConnect();
      }
    });
  }

  void _checkInternetAndConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isConnected = false;
      });
    } else {
      if (!_isConnected && !isConnecting) { // Only connect if not already connected or connecting
        setState(() {
          isConnecting = true;
        });
        await _connectToMqttServer();
      }
    }
  }


  Future<void> _connectToMqttServer() async {
    await mqttClientWrapper.connect(); // Wait for connection
    setState(() {
      _isConnected = mqttClientWrapper.isConnected;
      isConnecting = false;
    });
    if (_isConnected) {
      mqttClientWrapper.stv('admin2/monitoringsystem2'); // Subscribe to MQTT topic
    }
  }






  /*void _connectToMqttServer() async {
    await mqttClientWrapper.connect(); // Wait for connection
    setState(() {
      isConnected = mqttClientWrapper.isConnected;
    });
    if (isConnected) {
      mqttClientWrapper.stv('admin2/monitoringsystem2'); // Subscribe to MQTT topic
    }
  }*/

  int _selectedIndex = 0;
  final List<String> _appBarTitles = ['Dashboard', 'HVAC', 'Water Flow', 'About'];

  static final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(),
    const HVAC(),
    const WaterFlow(),
    const About(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(0, 72, 0, 1),
        title: Text(
          _appBarTitles[_selectedIndex],
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 17),
            child: ElevatedButton(
              onPressed: () {

                  _connectToMqttServer();

              },
              child: Row(
                children: [
                  Text(
                    _isConnected ? 'Connected' : 'Connecting...',
                    style: const TextStyle(color: Color.fromRGBO(42, 40, 70, 1)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 13,
                    child: CircleAvatar(
                      backgroundColor: _isConnected
                          ? const Color.fromRGBO(0, 72, 0, 1)
                          : Colors.red, // Change indicator color based on connection state
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children:[

          AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
          if (!_isConnected)
              Container(
                color: Colors.white.withOpacity(0.8),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(0, 72, 0, 1),
                  ),
                ),
              ),

      ]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromRGBO(0, 72, 0, 1), // Active icon color
        unselectedItemColor: Colors.black, // Inactive icon color
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.heat_pump_outlined),
            label: 'HVAC',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hvac_outlined),
            label: 'Water Flow',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
