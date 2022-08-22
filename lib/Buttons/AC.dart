// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_hvac/kuksa-server/vehicle-provider.dart';
import 'package:flutter_hvac/kuksa-server/vehicle_methods.dart';

import '../size.dart';

class AC extends ConsumerStatefulWidget {
  WebSocket socket;
  String serverPath;
  AC({
    Key? key,
    required this.serverPath,
    required this.socket,
  }) : super(key: key);

  @override
  _ACState createState() => _ACState();
}

class _ACState extends ConsumerState<AC> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late bool isAcActive;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _colorAnimation =
        ColorTween(begin: Colors.lightBlueAccent, end: Colors.white)
            .animate(_controller);

    _controller.addListener(() {
      // print(_controller.value);
      // print(_colorAnimation.value);
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        VISS.set(widget.socket, widget.serverPath, isAcActive.toString());
      }
      if (status == AnimationStatus.dismissed) {
        VISS.set(widget.socket, widget.serverPath, isAcActive.toString());
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
    isAcActive = ref.watch(vehicleProvider).isAcActive;
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
                gradient: isAcActive
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
                borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical*2),
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
                      'A/C',
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
              isAcActive ? _controller.reverse() : _controller.forward();
              ref
                  .read(vehicleProvider.notifier)
                  .update(isAcActive: !isAcActive);
            },
          );
          // return IconButton(
          //   icon: Icon(
          //     Icons.favorite,
          //     color: _colorAnimation.value,
          //     size: 30,
          //   ),
          //   onPressed: () {
          //     isFav ? _controller.reverse() : _controller.forward();
          //   },
          // );
        });
  }
}
