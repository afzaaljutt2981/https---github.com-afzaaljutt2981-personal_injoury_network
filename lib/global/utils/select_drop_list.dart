import 'package:flutter/material.dart';

import 'drop_list_model.dart';

class SelectDropList extends StatefulWidget {
  final OptionItem itemSelected;
  final DropListModel dropListModel;
  final Function(OptionItem optionItem) onOptionSelected;

  SelectDropList(this.itemSelected, this.dropListModel, this.onOptionSelected);

  @override
  _SelectDropListState createState() =>
      _SelectDropListState(itemSelected, dropListModel);
}

class _SelectDropListState extends State<SelectDropList>
    with SingleTickerProviderStateMixin {
  OptionItem optionItemSelected;
  final DropListModel dropListModel;

  late AnimationController expandController;
  late Animation<double> animation;

  bool isShow = false;

  _SelectDropListState(this.optionItemSelected, this.dropListModel);

  @override
  void initState() {
    super.initState();
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  // Container(
  //               width: 130,
  //               height: 37.49,
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(5.0),color: Color(0xFFD2D7F2)
  //               ),
  //               padding: const EdgeInsets.all(10.0),
  //               child: Row(
  //                 children: [
  //                   SizedBox(width: 8.0),
  //                   Text('Category'),
  //                   Spacer(),
  //                   Icon(Icons.arrow_drop_down),
  //                 ],
  //               ),
  //             ),
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          this.isShow = !this.isShow;
          _runExpandCheck();
          setState(() {});
        },
        child: Padding(
          padding: EdgeInsets.only(right: 15, bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 130,
                height: 37.49,
                // padding: const EdgeInsets.symmetric(
                //     horizontal: 15, vertical: 17),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Color(0xFFD2D7F2)),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: 8.0),
                    Text(optionItemSelected.title),
                    Spacer(),
                    !isShow
                        ? Icon(Icons.arrow_drop_down)
                        : Icon(Icons.arrow_drop_up),
                  ],
                  // new Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     Icon(Icons.card_travel, color: Color(0xFF307DF1),),
                  //     SizedBox(width: 10,),
                  //     Expanded(
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             this.isShow = !this.isShow;
                  //             _runExpandCheck();
                  //             setState(() {
                  //
                  //             });
                  //           },
                  //           child: Text(optionItemSelected.title, style: TextStyle(
                  //               color: Color(0xFF307DF1),
                  //               fontSize: 16),),
                  //         )
                  //     ),
                  //     Align(
                  //       alignment: Alignment(1, 0),
                  //       child: Icon(
                  //         isShow ? Icons.arrow_drop_down : Icons.arrow_right,
                  //         color: Color(0xFF307DF1),
                  //         size: 15,
                  //       ),
                  //     ),
                  //   ],
                ),
              ),
              SizeTransition(
                  axisAlignment: 1.0,
                  sizeFactor: animation,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: 130,
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.only(bottom: 10),
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                  color: Colors.white,
                                  boxShadow: [
                                    // BoxShadow(
                                    //     blurRadius: 4,
                                    //     color: Colors.black26,
                                    //     offset: Offset(0, 4))
                                  ],
                                ),
                                child: _buildDropListOptions(
                                    dropListModel.listOptionItems, context))
                          ],
                        )
                      ])),
//          Divider(color: Colors.grey.shade300, height: 1,)
            ],
          ),
        ),
      ),
    );
  }

  Column _buildDropListOptions(List<OptionItem> items, BuildContext context) {
    return Column(
      children: items.map((item) => _buildSubMenu(item, context)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItem item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, top: 5, bottom: 5),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Expanded(
              // flex: 1,
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                decoration: item.id == "2"
                    ? BoxDecoration(
                        border: Border(
                            top:
                                BorderSide(color: Color(0xFF847FB3), width: 1)),
                      )
                    : null,
                child: Text(item.title,
                    style: TextStyle(
                        color: Color(0xFF847FB3),
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
        onTap: () {
          this.optionItemSelected = item;
          isShow = false;
          expandController.reverse();
          widget.onOptionSelected(item);
        },
      ),
    );
  }
}
