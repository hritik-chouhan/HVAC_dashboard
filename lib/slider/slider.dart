import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slider_controller/slider_controller.dart';
import 'package:untitled/provider.dart';

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
      // child: SliderController(
      //   value: 20,
      //     onChanged: (value){
      //           print(value);
      //     },

      //   min: 0.0,
      //   max: 100.0,
      //   sliderDecoration: SliderDecoration(
      //     inactiveColor: Colors.white,
      //     activeColor: Colors.orangeAccent,
      //     thumbColor: Colors.white,
      //     borderRadius: 5.0,
      //     height: 10.0,
      //     isThumbVisible: true,
      //     thumbHeight: 9.0,
      //     thumbWidth: 5.0,
      //   ),

      // ),
      child: Slider(
        value: ref.watch(fanSpeedProvider).toDouble(),
        onChanged: (value) {
          ref.read(fanSpeedProvider.notifier).update(value.toInt());
          VISS.set(socket, 'Vehicle.Cabin.HVAC.Station.Row1.Left.FanSpeed',
              value.toInt().toString());
          VISS.set(socket, 'Vehicle.Cabin.HVAC.Station.Row1.Right.FanSpeed',
              value.toInt().toString());
          VISS.set(socket, 'Vehicle.Cabin.HVAC.Station.Row2.Left.FanSpeed',
              value.toInt().toString());
          VISS.set(socket, 'Vehicle.Cabin.HVAC.Station.Row2.Right.FanSpeed',
              value.toInt().toString());
        },
        min: 0,
        max: 100,
        activeColor: Colors.blueAccent,
        inactiveColor: Colors.white70,
        thumbColor: Colors.greenAccent,
        label: 'fan speed',
      ),
    );
  }
}
