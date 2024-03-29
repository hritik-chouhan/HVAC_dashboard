// SPDX-License-Identifier: Apache-2.0

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hvac/provider.dart';

import '../kuksa-server/vehicle_methods.dart';
import '../size.dart';

class SliderControl extends ConsumerWidget {
  WebSocket socket;
  SliderControl({Key? key, required this.socket}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: SizeConfig.safeBlockVertical*2,
      width: SizeConfig.screenWidth*0.5,

      child: Slider(
        value: ref.watch(fanSpeedProvider).toDouble(),
        onChanged: (value) {
          ref.read(fanSpeedProvider.notifier).update(value.toInt());
          VISS.set(socket, ref,'Vehicle.Cabin.HVAC.Station.Row1.Left.FanSpeed',
              value.toInt().toString());
          VISS.set(socket, ref,'Vehicle.Cabin.HVAC.Station.Row1.Right.FanSpeed',
              value.toInt().toString());
          VISS.set(socket, ref,'Vehicle.Cabin.HVAC.Station.Row2.Left.FanSpeed',
              value.toInt().toString());
          VISS.set(socket,ref, 'Vehicle.Cabin.HVAC.Station.Row2.Right.FanSpeed',
              value.toInt().toString());
        },
        min: 0,
        max: 100,
        activeColor: Colors.green,
        inactiveColor: Colors.white70,
        thumbColor: Colors.grey,
        label: 'fan speed',
      ),
    );
  }
}
