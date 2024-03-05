import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

String receive = '';



class MqttClientWrapper with ChangeNotifier {
  MqttServerClient? client;
  bool _isConnected = false;
  bool get isConnected => _isConnected;
  double temp = 0;
  double humi = 0;





  Future<void> connect() async {
    client = MqttServerClient(
        'efb965ce5b544c28b2d64bec436a524d.s1.eu.hivemq.cloud',
        'efb965ce5b544c28b2d64bec436a524d');
    client!.port = 8883; // If using secure connection
    client!.secure = true; // If using secure connection

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier('efb965ce5b544c28b2d64bec436a524d')
        .startClean() // Start with a clean session
        .withWillTopic('admin2/monitoringsystem2')
        .withWillMessage('Successfully Connected')
        .withWillQos(MqttQos.atLeastOnce)
        .authenticateAs('admin', 'ATmega32u');
    client!.connectionMessage = connMess;

    try {
      await client!.connect();
      _isConnected =
          client!.connectionStatus!.state == MqttConnectionState.connected;
      notifyListeners();
    } catch (e) {
      print('Exception: $e');
      client!.disconnect();
    }

    if (client!.connectionStatus!.state == MqttConnectionState.connected) {
      print('Connected to the broker!');
    } else {
      print('Failed to connect to the broker.');
    }
    notifyListeners();
  }

  void disconnect() {
    client!.disconnect();
    _isConnected = false;
    print('Disconnect from MQTT');
    notifyListeners();
  }

  void publish(String topic, String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client!.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
    print(message);
  }

  void subscribeToTopic(String topicName) {
    print('Subscribing to the $topicName topic');
    client!.subscribe(topicName, MqttQos.atMostOnce);
    //print the message when it is received
    client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      var message =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('YOU GOT A NEW MESSAGE:');
      print(message);
      receive = message;

    });
  }
  void updateConnectionStatus(bool isConnected)
  {
    _isConnected = isConnected;
    notifyListeners();

  }



 void stv(String topicName) {
    print('Subscribing to the $topicName topic');
    client!.subscribe(topicName, MqttQos.atMostOnce);
    //print the message when it is received
    client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      var message =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('YOU GOT A NEW MESSAGE:');
      print(message);
      // Assuming temperature value is at a specific position in the message
      // You can extract it using substring
      if (message.length >= 15) { // Assuming the message has at least 20 characters
        String temperatureString = message.substring(12, 14); // Extract temperature value from position 6 to 10
        String humiString = message.substring(10, 12);
        // Parse temperature value to double
        double temperature = double.tryParse(temperatureString) ?? 0.0;
        // Store the temperature value in a variable or use it as needed
        double humidity = double.tryParse(humiString) ?? 0.0;

        print('Temperature: $temperature');
        print('Humidity: $humidity');
        // Now you can store the temperature value in a variable or use it as needed
        // For example, you could have a class-level variable to store the temperature value
        // For simplicity, I'm assuming receive is a class-level variable
        temp = temperature;
        humi = humidity;
      } else {
        print('Invalid message format');
      }
    });
  }




}