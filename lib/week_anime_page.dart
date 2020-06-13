import 'package:flutter/material.dart';
import 'package:flutter_player/bean/week_amime.dart';
import 'package:dio/dio.dart';
import 'package:flutter_player/list_item.dart';
import 'package:flutter_player/item_detail_page.dart';
import 'package:flutter_player/util//loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class RecentUpdate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IndexWidget();
  }
}
class IndexWidget extends State<RecentUpdate>{

  List<RstData> _listData;//设置列表数据
  GlobalKey<ScaffoldState> _globalKeyState=GlobalKey();
  ScrollController _scrollController=ScrollController();
  int pager=1;
  String href = "";
  bool _loading = false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("最近更新",style: TextStyle(color: Colors.white),),
//        leading: Icon(Icons.menu,color: Colors.white,),
        backgroundColor: Color(0xffd43d3d),
      ),
      body: _listInfos(),
    );
  }

  //list列表
  Widget _listInfos(){
    return Scaffold(
      key: _globalKeyState,
      body: ProgressDialog(
        loading: _loading,
        msg: '正在加载...',
        child: RefreshIndicator(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing:5,
                crossAxisSpacing:20,
              ),
              itemCount: _listData==null?0:_listData.length,//此处 +1 是为了在最后添加一个progress
              itemBuilder: (content,index){
                return _listItem(index);
              },
              controller: _scrollController,
            ),
            onRefresh: _onRefresh_1
        ),
      ),
    );
  }
  //list列表的item
  //item
  Widget _listItem(int index){
      RstData data=_listData[index];
      return new InkWell(
        child: IndexItem(rstData: data,),
        onTap:(){ _itemClick(data);},
      );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    //项目加载时去获取数据
    getHttp().then((_){
      setState(() {
        _loading = !_loading;
        Fluttertoast.showToast(msg: '加载完成');
      });
    });
  }

  Future<Null> getHttp() async {
    try {
      Response response;
      response=await Dio().get("http://47.104.97.146:5000/recent");
      //List responseJson = json.decode(response.data);
      RespResult respResult = RespResult.fromJson(response.data);
      setState(() {
        _listData=respResult.data;
      });
    } catch (e) {
      print(e);
    }
    return null;
  }
//  void _itemClick(RstData data){
//    Navigator.push(context, MaterialPageRoute(builder: (cx)=>ItemInfoDetail(id: data.id,title: data.title,)));
//  }
  //下拉刷新
  Future<Null> _onRefresh() async {
    pager=1;
    FormData formData=FormData();
    getHttp();
    return null;
  }

  _itemClick(RstData rstData){
    Navigator.push(context, MaterialPageRoute(builder: (cx)=>ItemInfoDetail(href:rstData.href,name: rstData.name)));
  }

  Future<Null> _onRefresh_1() async {
    setState(() {
      _loading = !_loading;
    });
    await getHttp().then((_){
      setState(() {
        _loading = !_loading;
        Fluttertoast.showToast(msg: '加载完成');
      });
    });
    return null;
  }
}