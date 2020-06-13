import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_player/bean/day_anime.dart';
import 'package:flutter_player/search_page.dart';
import 'bean/tab_title.dart';
import 'item_detail_page.dart';
import 'package:flutter_player/week_anime_page.dart';

class TabHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TabBar1();
  }
}

class TabBar1 extends State<TabHome> with SingleTickerProviderStateMixin {
  TabController mController;
  List<TabTitle> tabList;
  List<DayData> _listData;
  @override
  void initState() {
    super.initState();
    initTabData();
    mController = TabController(
      length: tabList.length,
      vsync: this,
    );
    getHttp();
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  initTabData() {
    tabList = [
      new TabTitle('周一', 1),
      new TabTitle('周二', 2),
      new TabTitle('周三', 3),
      new TabTitle('周四', 4),
      new TabTitle('周五', 5),
      new TabTitle('周六', 6),
      new TabTitle('周日', 0),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("追番列表"),
        backgroundColor: Color(0xffd43d3d),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.today),
        backgroundColor: Color(0xffd43d3d),
        elevation: 2.0,
        highlightElevation: 2.0,
        onPressed: () {
          showSearch(context: context, delegate: SearchBarDelegate());
        },
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: new Color(0xfff4f5f6),
            height: 38.0,
            child: TabBar(
              isScrollable: true,
              //是否可以滚动
              controller: mController,
              labelColor: Colors.red,
              unselectedLabelColor: Color(0xff666666),
              labelStyle: TextStyle(fontSize: 16.0),
              tabs: tabList.map((item) {
                return Tab(
                  text: item.title,
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: mController,
              children: tabList.map((item) {
                return Stack(children: <Widget>[
                  getBody(item.weekday)
                ],);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
  Future<Null> getHttp() async {
    try {
      Response response;
      response=await Dio().get("http://47.104.97.146:5000/");
      //List responseJson = json.decode(response.data);
      DayTotal respResult = DayTotal.fromJson(response.data);
      setState(() {
        _listData=respResult.data;
      });
    } catch (e) {
      print(e);
    }
    return null;
  }
  getBody(int day) {
    List<DayData> list = new List();
    if (_listData != null) {
      for(int i=0;i<_listData.length;i++){
        if(_listData[i].wd == day){
          list.add(_listData[i]);
        }
      }
      return ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int position) {
            return GestureDetector(
              child: getItem(list[position]),
              onTap:(){ _itemClick(list[position]);},
            );
          });
    } else {
      // 加载菊花
      return Align(alignment: Alignment.topCenter,child: CupertinoActivityIndicator(),);
    }
  }
  _itemClick(DayData data){
    Navigator.push(context, MaterialPageRoute(builder: (cx)=>ItemInfoDetail(href:"/detail/"+data.id.toString(),name: data.name)));
  }
  getItem(DayData anime){

    return Container(
      height: 40,

      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: Text(anime.name),
          ),
            Text(anime.namefornew),


        ],
      ),
    );
  }
}