import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slider_controller/slider_controller.dart';
import 'package:untitled/provider.dart';

import '../size.dart';

class ClimateSliderControlLeft extends ConsumerWidget {
  const ClimateSliderControlLeft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    int val = ref.watch(LeftSlider).toInt();

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
            ref.read(LeftSlider.notifier).update(value.toInt());
          },
          activeColor: Colors.orangeAccent,
          inactiveColor: Colors.white,
          thumbColor: Colors.blueAccent,
        ),
        // child: SliderController(value: 0,
        //   onChanged: (value){
        //   ref.read(LeftSlider.notifier).update(value.toInt());
        //   },
        //
        //   min: 0,
        //   max: 15,
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
        //
        // ),
      ),
    );

  }
}
