import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_hvac/kuksa-server/vehicle-class.dart';
import 'package:flutter_hvac/kuksa-server/vehicle-provider.dart';
import 'package:flutter_hvac/kuksa-server/vehicle_methods.dart';
import 'package:flutter_hvac/size.dart';

class CaustomButton extends ConsumerStatefulWidget {
  WebSocket socket;
  String serverPath;
  String img;
  String type;
  CaustomButton({
    Key? key,
    required this.serverPath,
    required this.socket,
    required this.img,
    required this.type,
  }) : super(key: key);

  @override
  _CaustomButtonState createState() => _CaustomButtonState();
}

class _CaustomButtonState extends ConsumerState<CaustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late vehicle vehicledata;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.green)
            .animate(_controller);

    _controller.addListener(() {

    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.type == 'Front_defrost') {
          VISS.set(widget.socket, widget.serverPath,
              vehicledata.isFrontDefrosterActive.toString());
        }
        if (widget.type == "Rear_defrost") {
          VISS.set(widget.socket, widget.serverPath,
              vehicledata.isRearDefrosterActive.toString());
        }
        if (widget.type == "Recirculation") {
          VISS.set(widget.socket, widget.serverPath,
              vehicledata.isRecirculationActive.toString());
        }



      }
      if (status == AnimationStatus.dismissed) {
        if (widget.type == 'Front_defrost') {
          VISS.set(widget.socket, widget.serverPath,
              vehicledata.isFrontDefrosterActive.toString());
        }
        if (widget.type == "Rear_defrost") {
          VISS.set(widget.socket, widget.serverPath,
              vehicledata.isRearDefrosterActive.toString());
        }
        if (widget.type == "Recirculation") {
          VISS.set(widget.socket, widget.serverPath,
              vehicledata.isRecirculationActive.toString());
        }
      }
    });
  }

  // dismiss the animation when widget exits screen
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    vehicledata = ref.watch(vehicleProvider);
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
                gradient: widget.type == "Front_defrost"
                    ? vehicledata.isFrontDefrosterActive
                        ? RadialGradient(
                            colors: [Colors.black, Colors.lightBlue],
                            radius: 2,
                          )
                        : null
                    : widget.type == "Rear_defrost"
                        ? vehicledata.isRearDefrosterActive
                            ? RadialGradient(
                                colors: [Colors.black, Colors.lightBlue],
                                radius: 2,
                              )
                            : null
                        : vehicledata.isRecirculationActive
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
              duration: Duration(milliseconds: 100),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                margin: EdgeInsets.all(SizeConfig.blockSizeVertical),
                child: Image(
                  width: SizeConfig.screenWidth*0.15,
                  height: SizeConfig.screenHeight*0.10,
                  image: Svg(widget.img),
                  color: _colorAnimation.value,
                ),
              ),
            ),
            onTap: () {
              if (widget.type == "Front_defrost") {
                vehicledata.isFrontDefrosterActive
                    ? _controller.reverse()
                    : _controller.forward();
                ref.read(vehicleProvider.notifier).update(
                    isFrontDefrosterActive:
                        !vehicledata.isFrontDefrosterActive);
              }
              if (widget.type == "Rear_defrost") {
                vehicledata.isRearDefrosterActive
                    ? _controller.reverse()
                    : _controller.forward();
                ref.read(vehicleProvider.notifier).update(
                    isRearDefrosterActive: !vehicledata.isRearDefrosterActive);
              }
              if (widget.type == "Recirculation") {
                vehicledata.isRecirculationActive
                    ? _controller.reverse()
                    : _controller.forward();
                ref.read(vehicleProvider.notifier).update(
                    isRecirculationActive: !vehicledata.isRecirculationActive);
              }
            },
          );

        });
  }
}
