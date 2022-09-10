// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hvac/provider.dart';

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
          activeColor: Colors.green,
          inactiveColor: Colors.white,
          thumbColor: Colors.grey,
        ),

      ),
    );

  }
}
