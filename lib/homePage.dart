import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:untitled/Buttons/AC.dart';
import 'package:untitled/Buttons/button.dart';
import 'package:untitled/slider/Climate_slider.dart';
import 'package:untitled/slider/Right_climate_slider.dart';
import 'Buttons/auto.dart';
import 'widgets/Right_climate.dart';
import 'widgets/left_climate.dart';
import 'slider/slider.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(height);
    print(width);
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('HVAC'),
        // ),
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
                bottom: 180,
                left: 10,
                child: Heart(img: 'ac_on_foot.svg',)),
            Positioned(
                bottom: 90,
                left: 10,
                child: Heart(img: 'ac_on_face.svg',)),
            Positioned(
                bottom: 0,
                left: 10,
                child: Heart(img: 'face_foot.svg',)),



            Positioned(
              left: width/3,
              right: width/3.34,
              bottom: 45,
              child: Row(
                children: [
                Auto(),
                SizedBox(width: 10,),
                AC(),
                  SizedBox(width: 10,),

                  Heart(img: 'in_out.svg',),
                  ],
              ),
            ),
            // Positioned(
            //     bottom: 85,
            //     left: 310,
            //     child: Auto()),
            // Positioned(
            //     bottom: 105,
            //     left : 459,
            //     child: AC()),
            // Positioned(
            //     bottom: 105,
            //     left: 590,
            //     child: Heart(img: 'in_out.svg',)),



            Positioned(
                bottom: 180,
                right: 10,
                child: Heart(img: 'wind_shield.svg',)),
            Positioned(
                bottom: 90,
                right: 10,
                child: Heart(img: 'wind_in.svg',)),
            Positioned(
                bottom: 0,
                right: 10,
                child: Heart(img: 'rear_ws.svg',)),

            Positioned(
                bottom: 180,
                left: width*3.5/10,
                child: SliderControl()),
            Positioned(
              bottom: 100,
              left: width*1.8/10,
              child: Image(

                width: 200,
                height: 200,
                image: Svg('fan.svg'),
                color: Colors.lightBlueAccent,
              ),),
            // Positioned(
            //   left: width*1.8/10,
            //   top: 5,
            //
            //   child: SizedBox(
            //   height: height/10,
            //     width: width/10,
            //     child: Image.asset('left_climate.PNG')),
            // ),
            // Positioned(
            //     top: height/3.8,
            //     left: width*1.8/10,
            //     child: ScrollContainer()),
            Positioned(
              top: 50,
                left: width*1.8/10,
                child: Column(children: [
                  Text('L CLIMATE',
                    style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.w700,
                      color: Colors.orangeAccent,
                    ),
                  ),
              SizedBox(height: 5,),
              SizedBox(
                height: height*0.15,
                width: width*0.15,
                child: Image.asset('left_climate.PNG')),
              SizedBox(height: 5,),
              ScrollContainerLeft(),
            ],)),
            Positioned(
              top: 50,
              left: 50,
                bottom: 300,
                child: ClimateSliderControlLeft()),


            Positioned(
                top: 50,
                right: width*1.8/10,
                child: Column(children: [
                  Text('R CLIMATE',
                    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  SizedBox(height: 5,),
                  SizedBox(
                      height: height*0.15,
                      width: width*0.15,
                      child: Image.asset('right_climate.PNG')),
                  SizedBox(height: 5,),
                  ScrollContainerRight(),
                ],)),
            Positioned(
                top: 50,
                right: 50,
                bottom: 300,
                child: ClimateSliderControlRight()),





          ],
        )
    );
  }
}