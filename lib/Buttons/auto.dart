// SPDX-License-Identifier: Apache-2.0

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hvac/kuksa-server/vehicle-provider.dart';

import '../size.dart';

class Auto extends ConsumerStatefulWidget {
  WebSocket socket;
  String serverPath;
  Auto({
    Key? key,
    required this.serverPath,
    required this.socket,
  }) : super(key: key);

  @override
  _AutoState createState() => _AutoState();
}

class _AutoState extends ConsumerState<Auto> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late bool isAutoActive;
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

    _controller.addListener(() {

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
    isAutoActive = ref.watch(vehicleProvider).isAutoActive;
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
                gradient: isAutoActive
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
              duration: Duration(seconds: 1),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                margin: EdgeInsets.all(SizeConfig.blockSizeVertical*2),
                child: Container(
                  width: SizeConfig.screenWidth*0.15,
                  height: SizeConfig.screenHeight*0.10,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      'AUTO',
                      style: TextStyle(
                        color: _colorAnimation.value,
                        fontWeight: FontWeight.w700,
                        // fontSize: SizeConfig.fontsize*4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {
              isAutoActive ? _controller.reverse() : _controller.forward();
              ref
                  .read(vehicleProvider.notifier)
                  .update(isAutoActive: !isAutoActive);
            },
          );

        });
  }
}
