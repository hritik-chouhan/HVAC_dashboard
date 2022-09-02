import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_hvac/kuksa-server/vehicle-provider.dart';

import '../kuksa-server/vehicle-class.dart';
import '../kuksa-server/vehicle_server_path.dart';
import '../kuksa-server/vehicle_methods.dart';
import '../size.dart';

class AcOnFace extends ConsumerStatefulWidget {
  final String img;
  WebSocket socket;
  AcOnFace({
    Key? key,
    required this.img,
    required this.socket,
  }) : super(key: key);

  @override
  _AcOnFaceState createState() => _AcOnFaceState();
}

class _AcOnFaceState extends ConsumerState<AcOnFace>
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
            "Vehicle.Cabin.HVAC.Station.Row1.Left.AirDistribution", 'up');
        VISS.set(widget.socket,
            "Vehicle.Cabin.HVAC.Station.Row1.Right.AirDistribution", 'up');
        VISS.set(widget.socket,
            "Vehicle.Cabin.HVAC.Station.Row2.Left.AirDistribution", 'up');
        VISS.set(widget.socket,
            "Vehicle.Cabin.HVAC.Station.Row2.Right.AirDistribution", 'up');
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
    if (vehicledata.isAcDirectionUp == false) {
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
              // color: Colors.black, //background color of box

              decoration: BoxDecoration(
                gradient: vehicledata.isAcDirectionUp
                    ? RadialGradient(
                        colors: [Colors.black, Colors.lightBlue],
                        radius: SizeConfig.safeBlockVertical/2,
                      )
                    : null,

                // color: _colorAnimation2.value,
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
              if (vehicledata.isAcDirectionDown) {
                ref
                    .watch(vehicleProvider.notifier)
                    .update(isAcDirectionDown: !vehicledata.isAcDirectionDown);
              }
              Future.delayed(Duration(milliseconds: 500),(){
                vehicledata.isAcDirectionUp
                    ? _controller.reverse()
                    : _controller.forward();

                ref.watch(vehicleProvider.notifier).update(
                  isAcDirectionUp: !vehicledata.isAcDirectionUp,
                );
              });

            },
          );
          // return IconButton(
          //   icon: Icon(
          //     Icons.favorite,
          //     color: _colorAnimation.value,
          //     size: 30,
          //   ),
          //   onPressed: () {
          //     isOn ? _controller.reverse() : _controller.forward();
          //   },
          // );
        });
  }
}
