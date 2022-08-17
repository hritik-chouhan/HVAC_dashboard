import 'dart:io';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_hvac/Buttons/AC.dart';
import 'package:flutter_hvac/Buttons/ac_on_face.dart';
import 'package:flutter_hvac/Buttons/ac_on_foot.dart';
import 'package:flutter_hvac/Buttons/button.dart';
import 'package:flutter_hvac/Buttons/defrost_recirculate.dart';
import 'package:flutter_hvac/size.dart';
import 'package:flutter_hvac/slider/Climate_slider.dart';
import 'package:flutter_hvac/slider/Right_climate_slider.dart';
import 'Buttons/auto.dart';
import 'kuksa-server/vehicle_server_path.dart';
import 'widgets/Right_climate.dart';
import 'widgets/left_climate.dart';
import 'slider/slider.dart';

class MyHomePage extends StatelessWidget {
  final WebSocket socket;
  MyHomePage({Key? key, required this.socket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
            child: AcOnFoot(
              img: 'images/ac_on_foot.svg',
              socket: socket,
            )),
        Positioned(
            bottom: 90,
            left: 10,
            child: AcOnFace(
              img: 'images/ac_on_face.svg',
              socket: socket,
            )),
        // Positioned(
        //     bottom: 0,
        //     left: 10,
        //     child: Heart(
        //       img: 'images/face_foot.svg',
        //       serverPath: 'abc',
        //       socket: socket,
        //       type: 'middle',
        //     )),

        Positioned(
          left: width / 3,
          right: width / 3.34,
          bottom: 45,
          child: Row(
            children: [
              // Auto(),
              SizedBox(
                width: 10,
              ),
              AC(
                  socket: socket,
                  serverPath: 'Vehicle.Cabin.HVAC.IsAirConditioningActive'),
              SizedBox(
                width: 10,
              ),
              // Heart(
              //   img: 'images/in_out.svg',
              //   socket: socket,
              //   serverPath: 'abc',
              //   type: 'fresh',
              // ),
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
          // child: Heart(
          //   img: 'images/wind_shield.svg',
          //   socket: socket,
          //   serverPath: 'Vehicle.Cabin.HVAC.IsFrontDefrosterActive',
          // )
          child: CaustomButton(
              serverPath: 'Vehicle.Cabin.HVAC.IsFrontDefrosterActive',
              socket: socket,
              img: 'images/wind_shield.svg',
              type: 'Front_defrost'),
        ),
        Positioned(
          bottom: 90,
          right: 10,
          // child: Heart(
          //   img: 'images/wind_in.svg',
          //   socket: socket,
          //   serverPath: 'abc',
          // )
          child: CaustomButton(
              serverPath: 'Vehicle.Cabin.HVAC.IsRecirculationActive',
              socket: socket,
              img: 'images/in_out.svg',
              type: 'Recirculation'),
        ),
        Positioned(
          bottom: 0,
          right: 10,
          // child: Heart(
          //   img: 'images/rear_ws.svg',
          //   socket: socket,
          //   serverPath: 'abc',
          // )
          child: CaustomButton(
              serverPath: 'Vehicle.Cabin.HVAC.IsRearDefrosterActive',
              socket: socket,
              img: 'images/rear_ws.svg',
              type: 'Rear_defrost'),
        ),

        Positioned(
            bottom: 180,
            left: width * 3.5 / 10,
            child: SliderControl(
              socket: socket,
            )),
        Positioned(
          bottom: 100,
          left: width * 1.8 / 10,
          child: Image(
            width: 200,
            height: 200,
            image: Svg('images/fan.svg'),
            color: Colors.lightBlueAccent,
          ),
        ),
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
            left: width * 1.8 / 10,
            child: Column(
              children: [
                Text(
                  'L CLIMATE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.orangeAccent,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                    height: height * 0.15,
                    width: width * 0.15,
                    child: Image.asset('images/left_climate.PNG')),
                SizedBox(
                  height: 5,
                ),
                ScrollContainerLeft(
                  socket: socket,
                ),
              ],
            )),
        Positioned(
            top: 50, left: 50, bottom: 300, child: ClimateSliderControlLeft()),

        Positioned(
            top: 50,
            right: width * 1.8 / 10,
            child: Column(
              children: [
                Text(
                  'R CLIMATE',
                  style: TextStyle(
                    fontSize: SizeConfig.fontsize,
                    fontWeight: FontWeight.w700,
                    color: Colors.orangeAccent,
                  ),
                ),
                SizedBox(
                    height: SizeConfig.screenHeight/10,
                    width: SizeConfig.screenWidth/10,
                    child: Image.asset('images/right_climate.PNG')),

                ScrollContainerRight(
                  socket: socket,
                ),
              ],
            )),
        Positioned(
            top: 50,
            right: 50,
            bottom: 300,
            child: ClimateSliderControlRight()),
      ],
    ));
  }
}
