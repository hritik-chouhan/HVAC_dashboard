import 'dart:io';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:untitled/Buttons/AC.dart';
import 'package:untitled/Buttons/ac_on_face.dart';
import 'package:untitled/Buttons/ac_on_foot.dart';
import 'package:untitled/Buttons/button.dart';
import 'package:untitled/Buttons/defrost_recirculate.dart';
import 'package:untitled/size.dart';
import 'package:untitled/slider/Climate_slider.dart';
import 'package:untitled/slider/Right_climate_slider.dart';
import 'Buttons/auto.dart';
import 'kuksa-server/vehicle_server_path.dart';
import 'widgets/Right_climate.dart';
import 'widgets/left_climate.dart';
import 'slider/slider.dart';

class MyHome_Page extends StatelessWidget {
  final WebSocket socket;
  MyHome_Page({Key? key, required this.socket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(height);
    print(width);
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Flex(direction: Axis.vertical,
        children: [
          Flexible(
            flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [

                      ClimateSliderControlLeft(),
                      SizedBox(width: SizeConfig.blockSizeHorizontal*4,),


                      Column(
                        children: [
                          Text(
                            'L CLIMATE',
                            style: TextStyle(
                              fontSize: SizeConfig.fontsize*4,
                              fontWeight: FontWeight.w700,
                              color: Colors.lightBlueAccent,
                            ),
                          ),

                          SizedBox(
                              height: SizeConfig.screenHeight/10,
                              width: SizeConfig.screenWidth/10,
                              child: Image.asset('images/left_climate.PNG')),

                          ScrollContainerLeft(
                            socket: socket,
                          ),
                        ],
                      ),


                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Column(
                        children: [
                          Text(
                            'R CLIMATE',
                            style: TextStyle(
                              fontSize: SizeConfig.fontsize*4,
                              fontWeight: FontWeight.w700,
                              color: Colors.lightBlueAccent,
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
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal*4,),

                      ClimateSliderControlRight(),
                    ],
                  ),

                ],
              )),
          Flexible(
            flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    width: SizeConfig.screenWidth*0.20,
                    height: SizeConfig.screenHeight*0.25,
                    image: Svg('images/fan.svg'),
                    color: Colors.lightBlueAccent,
                  ),
                  SliderControl(
                    socket: socket,
                  )
                ],
              )),
          Flexible(
            flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      AC(
                          socket: socket,
                          serverPath: 'Vehicle.Cabin.HVAC.IsAirConditioningActive'),
                      SizedBox(height: SizeConfig.safeBlockVertical,),

                      AcOnFoot(
                        img: 'images/ac_on_foot.svg',
                        socket: socket,
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical,),

                      AcOnFace(
                        img: 'images/ac_on_face.svg',
                        socket: socket,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CaustomButton(
                          serverPath: 'Vehicle.Cabin.HVAC.IsRecirculationActive',
                          socket: socket,
                          img: 'images/in_out.svg',
                          type: 'Recirculation'),
                      SizedBox(height: SizeConfig.safeBlockVertical,),
                      CaustomButton(
                          serverPath: 'Vehicle.Cabin.HVAC.IsRearDefrosterActive',
                          socket: socket,
                          img: 'images/rear_ws.svg',
                          type: 'Rear_defrost'),
                      SizedBox(height: SizeConfig.safeBlockVertical,),

                      CaustomButton(
                          serverPath: 'Vehicle.Cabin.HVAC.IsFrontDefrosterActive',
                          socket: socket,
                          img: 'images/wind_shield.svg',
                          type: 'Front_defrost'),
                    ],
                  ),
                ],
              )),
        ],


      ),
      );
  }
}
