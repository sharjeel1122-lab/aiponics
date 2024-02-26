import 'package:flutter/material.dart';
class HVAC extends StatefulWidget {
  const HVAC({super.key});

  @override
  State<HVAC> createState() => _HVACState();
}

class _HVACState extends State<HVAC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('HVAC'),
    );
  }
}
