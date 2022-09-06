import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_hvac/kuksa-server/vehicle-provider.dart';

import '../kuksa-server/vehicle-class.dart';
import '../kuksa-server/vehicle_methods.dart';
import '../size.dart';

class AcOnFoot extends ConsumerStatefulWidget {
  final String img;
  WebSocket socket;
  AcOnFoot({
    Key? key,
    required this.img,
    required this.socket,
  }) : super(key: key);

  @override
  _AcOnFootState createState() => _AcOnFootState();
}

class _AcOnFootState extends ConsumerState<AcOnFoot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _colorAnimation =
        ColorTween(begin: Colors.lightBlueAccent, end: Colors.green)
            .animate(_controller);

    _controller.addListener(() {});

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        VISS.set(widget.socket,
            "Vehicle.Cabin.HVAC.Station.Row1.Left.AirDistribution", 'down');
        VISS.set(widget.socket,
            "Vehicle.Cabin.HVAC.Station.Row1.Right.AirDistribution", 'down');
        VISS.set(widget.socket,
            "Vehicle.Cabin.HVAC.Station.Row2.Left.AirDistribution", 'down');
        VISS.set(widget.socket,
            "Vehicle.Cabin.HVAC.Station.Row2.Right.AirDistribution", 'down');

      }

      if (status == AnimationStatus.dismissed) {
        VISS.set(widget.socket,
            "Vehicle.Cabin.HVAC.Station.Row1.Left.AirDistribution", 'middle');
        VISS.set(widget.socket,
            "Vehicle.Cabin.HVAC.Station.Row1.Right.AirDistribution", 'middle');
        VISS.set(widget.socket,
            "Vehicle.Cabin.HVAC.Station.Row2.Left.AirDistribution", 'middle');
        VISS.set(widget.socket,
            "Vehicle.Cabin.HVAC.Station.Row2.Right.AirDistribution", 'middle');
      }
    });
  }

  // dismiss the animation when widgit exits screen
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    vehicle vehicledata = ref.watch(vehicleProvider);
    if (vehicledata.isAcDirectionDown == false) {
      _controller.reverse();
    }

    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, _) {
          return InkWell(
            child: AnimatedContainer(
              constraints: BoxConstraints(
                maxHeight: SizeConfig.screenHeight*0.10,
                maxWidth: SizeConfig.screenWidth*0.15,
              ),


              decoration: BoxDecoration(
                gradient: vehicledata.isAcDirectionDown
                    ? RadialGradient(
                        colors: [Colors.black, Colors.lightBlue],
                        radius: 2,
                      )
                    : null,


                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical*2),
              ),
              duration: const Duration(milliseconds: 500),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                margin: const EdgeInsets.all(10),
                child: Image(
                  width: SizeConfig.screenWidth*0.15,
                  height: SizeConfig.screenHeight*0.10,
                  image: Svg(widget.img),
                  color: _colorAnimation.value,
                ),
              ),
            ),
            onTap: () {
              if (vehicledata.isAcDirectionUp == true) {
                ref
                    .watch(vehicleProvider.notifier)
                    .update(isAcDirectionUp: !vehicledata.isAcDirectionUp);
              }
              Future.delayed(Duration(milliseconds: 500),(){
                vehicledata.isAcDirectionDown
                    ? _controller.reverse()
                    : _controller.forward();

                ref.watch(vehicleProvider.notifier).update(
                  isAcDirectionDown: !vehicledata.isAcDirectionDown,
                );
              });

            },
          );

        });
  }
}
