import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slider_controller/slider_controller.dart';
import 'package:flutter_hvac/provider.dart';

import '../size.dart';

class ClimateSliderControlRight extends ConsumerWidget {
  const ClimateSliderControlRight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    int val = ref.watch(RightSlider).toInt();
    return SizedBox(
      height: SizeConfig.screenHeight*0.35,
      width: SizeConfig.blockSizeHorizontal*3,
      child: RotatedBox(
        quarterTurns: 3,
        child: Slider(
          min: 0,
          max: 15,
          value: val.toDouble(),
          divisions: 15,
          onChanged: (value) {
            ref.read(RightSlider.notifier).update(value.toInt());
          },
          activeColor: Colors.lightBlueAccent,
          inactiveColor: Colors.white,
          thumbColor: Colors.blueAccent,
        ),
        // child: SliderController(
        //   value: 0,
        //   onChanged: (value) {
        //     ref.read(RightSlider.notifier).update(value.toInt());
        //   },
        //   min: 0,
        //   max: 17,
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
      ),
    );
  }
}
