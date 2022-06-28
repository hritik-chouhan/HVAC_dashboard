import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollContainer extends StatefulWidget {
  const ScrollContainer({Key? key}) : super(key: key);

  @override
  _ScrollContainerState createState() => _ScrollContainerState();
}

class _ScrollContainerState extends State<ScrollContainer> {
  List<int> mylist = [16,17,18,19,20,21,22,23,24];
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();


  void scrollTo(int index) => itemScrollController.scrollTo(
      index: index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      alignment: 1);

  @override
  Widget build(BuildContext context) {
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
            itemBuilder: (context,index){
            return ListTile(title: Text(mylist[index].toString(),
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
            ),);
            }),
        ),
        // constrain height
        // child: ListView.builder(
        //   scrollDirection: Axis.vertical,
        //   itemCount: mylist.length,
        //     itemBuilder: (context,index){
        //     return ListTile(title: Text('$mylist[index]'),);
        //     }),
      ),
    );
  }
}
