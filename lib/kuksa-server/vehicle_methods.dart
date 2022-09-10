// SPDX-License-Identifier: Apache-2.0

import 'dart:convert';
import 'dart:io';

import 'package:flutter_hvac/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hvac/kuksa-server/vehicle_server_path.dart';


class VISS {
  static const requestId = "test-id";
  static void init(WebSocket socket,WidgetRef ref) {
    authorize(socket,ref);

    subscribe(socket,ref, VSPath.vehicleFrontLeftTier);
    subscribe(socket,ref, VSPath.vehicleFrontRightTier);
    subscribe(socket,ref, VSPath.vehicleRearLeftTier);
    subscribe(socket,ref, VSPath.vehicleRearRightTier);
    subscribe(socket,ref, VSPath.vehicleIsChildLockActiveLeft);
    subscribe(socket,ref, VSPath.vehicleIsChildLockActiveRight);
    subscribe(socket,ref, VSPath.vehicleCurrentLatitude);
    subscribe(socket,ref, VSPath.vehicleCurrentLongitude);
    subscribe(socket,ref, VSPath.vehicleInsideTemperature);
    subscribe(socket,ref, VSPath.vehicleAmbientAirTemperature);
  }

  static void update(WebSocket socket,WidgetRef ref) {
    get(socket,ref, VSPath.vehicleAmbientAirTemperature);
    get(socket,ref, VSPath.vehicleTrunkLocked);
    get(socket, ref,VSPath.vehicleTrunkOpen);

    get(socket,ref, VSPath.vehicleFrontLeftTier);
    get(socket,ref, VSPath.vehicleFrontRightTier);
    get(socket,ref, VSPath.vehicleRearLeftTier);
    get(socket,ref, VSPath.vehicleRearRightTier);
    get(socket,ref, VSPath.vehicleIsChildLockActiveLeft);
    get(socket,ref, VSPath.vehicleIsChildLockActiveRight);
    get(socket,ref, VSPath.vehicleCurrentLatitude);
    get(socket,ref, VSPath.vehicleCurrentLongitude);
    get(socket,ref, VSPath.vehicleInsideTemperature);
  }

  static void authorize(WebSocket socket,WidgetRef ref) {
    final config = ref.read(ConfigStateprovider);
    Map<String, dynamic> map = {
      "action": "authorize",
      "tokens": config.kuksaAuthToken,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void get(WebSocket socket,WidgetRef ref ,String path) {
    final config = ref.read(ConfigStateprovider);

    Map<String, dynamic> map = {
      "action": "get",
      "tokens": config.kuksaAuthToken,
      "path": path,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void set(
    WebSocket socket,
    WidgetRef ref,
    String path,
    String value,
  ) {
    final config = ref.read(ConfigStateprovider);

    Map<String, dynamic> map = {
      "action": "set",
      "tokens": config.kuksaAuthToken,
      "path": path,
      "requestId": requestId,
      "value": value
    };
    socket.add(jsonEncode(map));
  }

  static void subscribe(WebSocket socket,WidgetRef ref, String path) {
    final config = ref.read(ConfigStateprovider);

    Map<String, dynamic> map = {
      "action": "subscribe",
      "tokens": config.kuksaAuthToken,
      "path": path,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }


}
