import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:untitled/kuksa-server/vehicle_methods.dart';
import 'package:untitled/provider.dart';
import 'package:untitled/size.dart';

class ScrollContainerRight extends ConsumerWidget {
  WebSocket socket;
  ScrollContainerRight({Key? key, required this.socket}) : super(key: key);

  List<int> mylist = [
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
  ];

  // late ItemScrollController _itemScrollController;
  //  IntialScrollController(ItemScrollController itemScrollController){
  //   _itemScrollController = itemScrollController;
  //   return _itemScrollController;
  // }
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context, ref) {
    int val = ref.watch(RightSlider).toInt();
    // _selected[val] = !_selected[val];
    // print(_selected[val]);
    // print(_selected[val+1]);
    // 'Vehicle.Cabin.HVAC.Station.Row1.Right.Temperature'
    VISS.set(socket, 'Vehicle.Cabin.HVAC.Station.Row1.Right.Temperature',
        mylist[val].toString());
    VISS.set(socket, 'Vehicle.Cabin.HVAC.Station.Row2.Right.Temperature',
        mylist[val].toString());
    print(val);

    if (itemScrollController.isAttached) {
      itemScrollController.scrollTo(
          index: val.toInt()+2,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          alignment: 1);
    }
    // itemPositionsListener.itemPositions.addListener(
    //   () => print(ItemPosition),
    // );

    return SingleChildScrollView(
      child: SizedBox(
        height: SizeConfig.screenHeight*0.30,
        width: SizeConfig.screenWidth*0.25,
        child: AnimatedContainer(
          // color: Colors.red,
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ScrollablePositionedList.builder(
            physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: mylist.length,
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    // color: _selected[val] ? Colors.white54 : null,
                    gradient: index == val
                        ? RadialGradient(
                            colors: [Colors.white54, Colors.black], radius: SizeConfig.safeBlockVertical*0.7)
                        : null,
                  ),
                  child: ListTile(
                    subtitle: Center(
                      child: Text(
                        '' + mylist[index].toString() + '°',
                        style: index == val ? TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.fontsize*12,
                        ):TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.fontsize*12,
                        ),
                      ),
                    ),
                    // tileColor: Colors.red,
                    minVerticalPadding: 5,
                    // selectedTileColor: ,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
