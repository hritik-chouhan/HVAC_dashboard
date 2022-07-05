import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slider_controller/slider_controller.dart';
import 'package:untitled/provider.dart';

class ClimateSliderControlLeft extends ConsumerWidget {
  const ClimateSliderControlLeft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {

    return SizedBox(
      height: 400,
      width: 15,
      child: RotatedBox(
        quarterTurns: 3,
        child: SliderController(value: 0,
          onChanged: (value){
          ref.read(LeftSlider.notifier).update(value.toInt());
          },

          min: 0,
          max: 16,
          sliderDecoration: SliderDecoration(
            inactiveColor: Colors.white,
            activeColor: Colors.orangeAccent,
            thumbColor: Colors.white,
            borderRadius: 5.0,
            height: 10.0,
            isThumbVisible: true,
            thumbHeight: 9.0,
            thumbWidth: 5.0,
          ),

        ),
      ),
    );

  }
}
