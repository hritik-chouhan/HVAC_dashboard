import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          activeColor: Colors.green,
          inactiveColor: Colors.white,
          thumbColor: Colors.grey,
        ),

      ),
    );
  }
}
