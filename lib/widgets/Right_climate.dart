import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:untitled/provider.dart';

class ScrollContainerRight extends ConsumerWidget {
  ScrollContainerRight({Key? key}) : super(key: key);

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
    32
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

    print(val);

    if (itemScrollController.isAttached) {
      itemScrollController.scrollTo(
          index: val.toInt() + 2,
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeInOutCubic,
          alignment: 1);
    }
    // itemPositionsListener.itemPositions.addListener(
    //   () => print(ItemPosition),
    // );

    return SingleChildScrollView(
      child: SizedBox(
        height: 200,
        width: 200,
        child: AnimatedContainer(
          // color: Colors.red,
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ScrollablePositionedList.builder(
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
                            colors: [Colors.white54, Colors.black], radius: 2)
                        : null,
                  ),
                  child: ListTile(
                    subtitle: Text(
                      '    ' + mylist[index].toString() + '°',
                      style: TextStyle(
                        color: Color.fromARGB(255, 59, 105, 126),
                        fontWeight: FontWeight.w700,
                        fontSize: 50,
                      ),
                    ),
                    tileColor: Colors.red,
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
