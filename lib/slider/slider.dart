import 'package:flutter/material.dart';
import 'package:slider_controller/slider_controller.dart';

class SliderControl extends StatelessWidget {
  const SliderControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: 400,
      child: SliderController(value: 20,
          onChanged: (value){
                print(value);
          },

        min: 0.0,
        max: 100.0,
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
    );

  }
}
