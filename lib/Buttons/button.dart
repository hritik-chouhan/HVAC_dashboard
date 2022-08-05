import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../kuksa-server/vehicle_server_path.dart';
import '../kuksa-server/vehicle_methods.dart';

class Heart extends StatefulWidget {
  final String img;
  WebSocket socket;
  final String serverPath;
  Heart(
      {Key? key,
      required this.img,
      required this.socket,
      required this.serverPath})
      : super(key: key);

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  bool isOn = false;
  bool radGrad = false;
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
        setState(() {
          isOn = true;
        });
        VISS.set(widget.socket, widget.serverPath, 'up');
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isOn = false;
        });
        VISS.set(widget.socket, widget.serverPath, 'middle');
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
                gradient: radGrad
                    ? RadialGradient(
                        colors: [Colors.black, Colors.lightBlue],
                        radius: 2,
                      )
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
              isOn ? _controller.reverse() : _controller.forward();

              setState(() {
                radGrad = !radGrad;
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
