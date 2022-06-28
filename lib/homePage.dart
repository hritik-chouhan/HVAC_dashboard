import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:untitled/Buttons/AC.dart';
import 'package:untitled/button.dart';
import 'Buttons/auto.dart';
import 'left_climate.dart';
import 'slider.dart';


class MyHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: Duration(milliseconds: 20));
    return Scaffold(
        appBar: AppBar(
          title: Text('HVAC'),
        ),
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: Colors.black,
              ),
            ),
            Positioned(
                bottom: 210,
                left: 10,
                child: Heart(img: 'ac_on_foot.svg',)),
            Positioned(
                bottom: 105,
                left: 10,
                child: Heart(img: 'ac_on_face.svg',)),
            Positioned(
                bottom: 0,
                left: 10,
                child: Heart(img: 'face_foot.svg',)),
            Positioned(
                bottom: 105,
                left: 310,
                child: Auto()),
            Positioned(
                bottom: 105,
                left : 459,
                child: AC()),
            Positioned(
                bottom: 105,
                left: 590,
                child: Heart(img: 'in_out.svg',)),
            Positioned(
                bottom: 210,
                right: 10,
                child: Heart(img: 'wind_shield.svg',)),
            Positioned(
                bottom: 105,
                right: 10,
                child: Heart(img: 'wind_in.svg',)),
            Positioned(
                bottom: 0,
                right: 10,
                child: Heart(img: 'rear_ws.svg',)),

            Positioned(
                bottom: 280,
                left: 350,
                child: SliderControl()),
            Positioned(
              bottom: 200,
              left: 190,
              child: Image(

                width: 200,
                height: 200,
                image: Svg('fan.svg'),
                color: Colors.lightBlueAccent,
              ),),
            Positioned(
                top: 50,
                left: 50,
                child: ScrollContainer()),





          ],
        )
    );
  }
}