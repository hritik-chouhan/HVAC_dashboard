import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_hvac/kuksa-server/vehicle-provider.dart';

import '../kuksa-server/vehicle-class.dart';
import '../kuksa-server/vehicle_server_path.dart';
import '../kuksa-server/vehicle_methods.dart';

class Heart extends ConsumerStatefulWidget {
  final String img;
  WebSocket socket;
  final String type;
  final String serverPath;
  Heart({
    Key? key,
    required this.img,
    required this.socket,
    required this.serverPath,
    required this.type,
  }) : super(key: key);

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends ConsumerState<Heart>
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
        ColorTween(begin: Colors.lightBlueAccent, end: Colors.white)
            .animate(_controller);

    _controller.addListener(() {});

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.type == "up") {
          VISS.set(widget.socket, widget.serverPath, 'up');
        }

        if (widget.type == "down") {
          VISS.set(widget.socket, widget.serverPath, 'down');
        }
      }

      if (status == AnimationStatus.dismissed) {
        if (widget.type == "up") {
          VISS.set(widget.socket, widget.serverPath, 'middle');
        }

        if (widget.type == "down") {
          VISS.set(widget.socket, widget.serverPath, 'middle');
        }
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

    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, _) {
          return InkWell(
            child: AnimatedContainer(
              constraints: BoxConstraints(
                maxHeight: 150,
                maxWidth: 200,
              ),
              // color: Colors.black, //background color of box

              decoration: BoxDecoration(
                gradient: widget.type == "up"
                    ? vehicledata.isAcDirectionUp
                        ? RadialGradient(
                            colors: [Colors.black, Colors.lightBlue],
                            radius: 2,
                          )
                        : null
                    : widget.type == " down"
                        ? vehicledata.isAcDirectionDown
                            ? RadialGradient(
                                colors: [Colors.black, Colors.lightBlue],
                                radius: 2,
                              )
                            : null
                        : null,

                // color: _colorAnimation2.value,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(milliseconds: 500),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                margin: const EdgeInsets.all(10),
                child: Image(
                  width: 80,
                  height: 60,
                  image: Svg(widget.img),
                  color: _colorAnimation.value,
                ),
              ),
            ),
            onTap: () {
              if (widget.type == "up") {
                vehicledata.isAcDirectionUp
                    ? _controller.reverse()
                    : _controller.forward();
                if(vehicledata.isAcDirectionUp == false && vehicledata.isAcDirectionDown == true){
                   ref
                    .watch(vehicleProvider.notifier)
                    .update(isAcDirectionUp: !vehicledata.isAcDirectionUp,
                    isAcDirectionDown: !vehicledata.isAcDirectionDown,
                    );
                }
                
               
              }

              if (widget.type == "down") {
                vehicledata.isAcDirectionDown
                    ? _controller.reverse()
                    : _controller.forward();
                ref
                    .watch(vehicleProvider.notifier)
                    .update(isAcDirectionDown: !vehicledata.isAcDirectionDown);
              }
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
