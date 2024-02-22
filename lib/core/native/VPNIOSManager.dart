// ignore: file_names
import 'package:flutter/services.dart';
import 'package:vpn/core/constants.dart';

enum StatusConnection { Offline, Online, Connecting, Stopped }

class ConnectionStatus {
  final StatusConnection? status;
  final int? lastMcc;
  final DateTime? dateConnection;

  ConnectionStatus({this.status, this.lastMcc, this.dateConnection});
  ConnectionStatus.fromData(this.status, this.lastMcc, this.dateConnection);
}

DateTime dateFromTimeIntervalSinceReferenceDate(double seconds) {
  int millisecondsSinceEpoch = (seconds * 1000).toInt();
  return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch,
      isUtc: true);
}

class VPNIOSManager {
  final MethodChannel _channel = const MethodChannel('vpn_manager');

  Future<bool> stopTun() async {
    try {
      await _channel.invokeMethod('stopTun');
      return true;
    } on PlatformException catch (e) {
      print("Failed to stop Tun: '${e.message}'.");
      return false;
    }
  }

  final EventChannel _eventChannel = const EventChannel('vpn_manager_event');

  Stream<ConnectionStatus> vpnStatusStream() {
    return _eventChannel.receiveBroadcastStream().map((result) {
      final status = convertStatusStringToEnum(result['status']);
      final lastMcc = result['lastMcc'];

      final dateConnection = result['dateConnection'] != null
          ? dateFromTimeIntervalSinceReferenceDate(result['dateConnection'])
          : null;
      return ConnectionStatus.fromData(status, lastMcc, dateConnection);
    });
  }

  Future<void> configureVPN({
    required String username,
    required String serverAddress,
    required String sharedSecret,
    required String password,
  }) async {
    try {
      await _channel.invokeMethod('configureVPN', {
        'username': username,
        'serverAddress': serverAddress,
        'sharedSecret': sharedSecret,
        'password': password,
      });
      return;
    } catch (e) {
      rethrow;
    }
  }

  StatusConnection convertStatusStringToEnum(String statusString) {
    switch (statusString) {
      case 'Offline':
        return StatusConnection.Offline;
      case 'Online':
        return StatusConnection.Online;
      case 'Connecting':
        return StatusConnection.Connecting;
      case 'Stopped':
        return StatusConnection.Stopped;
      default:
        return StatusConnection.Stopped;
    }
  }

  Future<ConnectionStatus> getStatus() async {
    try {
      final result = await _channel.invokeMethod('getStatus');
      final status = convertStatusStringToEnum(result['status']);
      final lastMcc = result['lastMcc'];
      print(result['dateConnection']);
      final dateConnection = result['dateConnection'] != null
          ? dateFromTimeIntervalSinceReferenceDate(result['dateConnection'])
          : null;
      return ConnectionStatus.fromData(status, lastMcc, dateConnection);
    } on PlatformException catch (e) {
      print("Failed to get status: '${e.message}'.");
      return emptyConnectionStatus;
    }
  }
}
