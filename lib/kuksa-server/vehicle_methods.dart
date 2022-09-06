import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hvac/kuksa-server/vehicle_server_path.dart';

import 'vehicle_config.dart';

class VISS {
  static const requestId = "test-id";
  static void init(WebSocket socket) {
    authorize(socket);

    subscribe(socket, VSPath.vehicleFrontLeftTier);
    subscribe(socket, VSPath.vehicleFrontRightTier);
    subscribe(socket, VSPath.vehicleRearLeftTier);
    subscribe(socket, VSPath.vehicleRearRightTier);
    subscribe(socket, VSPath.vehicleIsChildLockActiveLeft);
    subscribe(socket, VSPath.vehicleIsChildLockActiveRight);
    subscribe(socket, VSPath.vehicleCurrentLatitude);
    subscribe(socket, VSPath.vehicleCurrentLongitude);
    subscribe(socket, VSPath.vehicleInsideTemperature);
    subscribe(socket, VSPath.vehicleAmbientAirTemperature);
  }

  static void update(WebSocket socket) {
    get(socket, VSPath.vehicleAmbientAirTemperature);
    get(socket, VSPath.vehicleTrunkLocked);
    get(socket, VSPath.vehicleTrunkOpen);

    get(socket, VSPath.vehicleFrontLeftTier);
    get(socket, VSPath.vehicleFrontRightTier);
    get(socket, VSPath.vehicleRearLeftTier);
    get(socket, VSPath.vehicleRearRightTier);
    get(socket, VSPath.vehicleIsChildLockActiveLeft);
    get(socket, VSPath.vehicleIsChildLockActiveRight);
    get(socket, VSPath.vehicleCurrentLatitude);
    get(socket, VSPath.vehicleCurrentLongitude);
    get(socket, VSPath.vehicleInsideTemperature);
  }

  static void authorize(WebSocket socket) {
    Map<String, dynamic> map = {
      "action": "authorize",
      "tokens": VehicleSignalConfig.authToken,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void get(WebSocket socket, String path) {
    Map<String, dynamic> map = {
      "action": "get",
      "tokens": VehicleSignalConfig.authToken,
      "path": path,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void set(
    WebSocket socket,
    String path,
    String value,
  ) {
    Map<String, dynamic> map = {
      "action": "set",
      "tokens": VehicleSignalConfig.authToken,
      "path": path,
      "requestId": requestId,
      "value": value
    };
    socket.add(jsonEncode(map));
  }

  static void subscribe(WebSocket socket, String path) {
    Map<String, dynamic> map = {
      "action": "subscribe",
      "tokens": VehicleSignalConfig.authToken,
      "path": path,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static String? numToGear(int? number) {
    switch (number) {
      case -1:
        return 'R';
      case 0:
        return 'N';
      case 126:
        return 'P';
      case 127:
        return 'D';
      default:
        return null;
    }
  }
}
