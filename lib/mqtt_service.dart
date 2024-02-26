import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

String receive = '';


class MqttClientWrapper with ChangeNotifier {
  MqttServerClient? client;
  bool _isConnected = false;
  bool get isConnected => _isConnected;

  Future<void> connect() async {
    client = MqttServerClient(
        '0f84faf18b2d426b9e777d4d7487166b.s2.eu.hivemq.cloud',
        '0f84faf18b2d426b9e777d4d7487166b');
    client!.port = 8883; // If using secure connection
    client!.secure = true; // If using secure connection

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier('0f84faf18b2d426b9e777d4d7487166b')
        .startClean() // Start with a clean session
        .withWillTopic('FanControl')
        .withWillMessage('Hello Fan MQTT')
        .withWillQos(MqttQos.atLeastOnce)
        .authenticateAs('sharjeel1', 'Qwerty007');
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


  void stv(MqttClient client, String topicName) {
    print('Subscribing to the $topicName topic');

    if (client != null) {
      client.subscribe(topicName, MqttQos.atMostOnce);

      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        var message =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        print('YOU GOT A NEW MESSAGE:');
        print(message);

        int tempV = int.parse(message.substring(10, 12));
        int splitValue = int.parse(message.substring(12, 14));

        print('Temp Value: $tempV, Humidity Value: $splitValue');

        receive = message;
        notifyListeners();
      });

      print('Successfully subscribed to the $topicName topic');
    } else {
      print('Error: MqttClient is null');
    }
  }



}