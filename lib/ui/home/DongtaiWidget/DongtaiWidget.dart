import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xixi/tools/MyUITools/BaseTitleBar.dart';
import 'package:xixi/tools/MyUITools/BaseViewBar.dart';

class DongtaiWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DongtaiWidgetState();
  }

}

class DongtaiWidgetState extends State<DongtaiWidget>{


  var _showNarrow = false;
  var _oldShowState = false;
  var _scrollController = ScrollController();

  bool _onNotification(ScrollNotification notification) {

    bool show = _scrollController.offset > 100;
    if (show != _oldShowState) {
      _oldShowState = show;
      setState(() {
        _showNarrow = show;
      });
    }
    return true;
  }

//  void _functionTap(int index) {
//    Navigator.push(
//      context,
//      new MaterialPageRoute(
//          builder: (context) => new SearchPage(
//            type: index,
//          )),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      appBar: new BaseViewBar(
//          childView: new BaseTitleBar(
//            "动态",
//            null,
////            leftIcon: Icons.arrow_back_ios,
//            rightText: "",
//            rightClick: () {
////              print("点击了干嘛啊。。。哦");
//            },
//          ),
//          preferredSize: Size.fromHeight(50.0)
//      ),

        body: Stack(
          children: <Widget>[
            NotificationListener(
                onNotification: _onNotification,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, childAspectRatio: 1.8),
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return _ExpandWidget(show: !_showNarrow);
                        },
                        childCount: 1,
                      ),
                    ),
                    SliverFixedExtentList(
                      itemExtent: 50.0,
                        delegate: new SliverChildBuilderDelegate(
                              (context, index) => new ListTile(
                            title: new Text("List item $index"),
                            subtitle: new Text("this is subtitle"),
                          )),
                    )
                  ],
                  controller: _scrollController,
                )),
            _NarrowWidget(
              show: _showNarrow,
            ),
          ],
        )

    );
  }
}

// ignore: must_be_immutable
class _ExpandWidget extends StatefulWidget {
  var show = true;

  _ExpandWidget({this.show});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExpandWidgetState();
  }
}

class _ExpandWidgetState extends State<_ExpandWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (widget.show) {
      return Stack(
        children: <Widget>[
          Image.asset('images/dongtai.jpg',
              fit: BoxFit.fill, height: 100),
          Positioned(
            bottom: 15.0,
            left: 20,
            right: 20,
            child: Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.search),
                  Text("请输入关键字查询"),
                ],
              ),
              decoration: new BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: new BorderRadius.circular((5.0)),
              ),
              padding: EdgeInsets.all(8.0),
            ),
          ),
        ],
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
      );
    } else {
      return Container();
    }
  }
}

// ignore: must_be_immutable
class _NarrowWidget extends StatefulWidget {
  var show = false;

  _NarrowWidget({this.show});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NarrowWidgetState();
  }
}



class _NarrowWidgetState extends State<_NarrowWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (widget.show) {
      return Stack(
        children: <Widget>[
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 48, 20, 15),
                color: Color(0xFF52707A),
//                color: Color(0xfff7dfde),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.search),
                      Text("请输入关键字查询"),
                    ],
                  ),
                  decoration: new BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: new BorderRadius.circular((5.0)),
                  ),
                  padding: EdgeInsets.all(8.0),
                ),
              )),
        ],
        fit: StackFit.expand,
        alignment: Alignment.topCenter,
      );
    } else {
      return Container();
    }
  }
}