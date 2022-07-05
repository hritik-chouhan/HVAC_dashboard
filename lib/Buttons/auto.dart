import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class Auto extends StatefulWidget {
  Auto({Key? key, }) : super(key: key);

  @override
  _AutoState createState() => _AutoState();
}

class _AutoState extends State<Auto> with SingleTickerProviderStateMixin {
  bool isFav = false;
  bool radGrad = false;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<Color?> _colorAnimation2;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _colorAnimation = ColorTween(begin: Colors.lightBlueAccent, end: Colors.white).animate(_controller);
    _colorAnimation2 = ColorTween(begin: Colors.black, end: Colors.blueGrey).animate(_controller);


    _controller.addListener(() {
      // print(_controller.value);
      // print(_colorAnimation.value);
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
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
        builder: (BuildContext context, _){
          return InkWell(

            child: AnimatedContainer(
              constraints: BoxConstraints(
                maxHeight: 150,
                maxWidth: 160,
              ),
              // color: Colors.black, //background color of box

              decoration: BoxDecoration(
                gradient: radGrad? RadialGradient(colors: [Colors.black,Colors.lightBlue],
                  radius: 2,
                ) : null,


                // color: _colorAnimation2.value,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              duration: Duration(seconds: 1),
              child: AnimatedContainer(
                margin: EdgeInsets.fromLTRB(20, 26, 20, 26),


                duration: Duration(milliseconds: 100),
                child: Text('AUTO',style: TextStyle(
                  color: _colorAnimation.value,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),


                ),
              ),


            ),
            onTap: (){
              isFav ? _controller.reverse() : _controller.forward();
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
          //     isFav ? _controller.reverse() : _controller.forward();
          //   },
          // );
        }
    );
  }
}