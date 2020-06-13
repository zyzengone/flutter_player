import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_player/bean/true_url.dart';
import 'package:flutter_player/player.dart';
import 'package:flutter_player/util//loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_player/bean/anime_detail.dart';

class ItemInfoDetail extends StatefulWidget{

  String href;
  String name;
  ItemInfoDetail({this.href,this.name});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InfoDetail(href: href,name: name);
  }

}

class InfoDetail  extends State<ItemInfoDetail>{
  String href;
  String name;
  String true_url;
  bool _loading = false;
  List<EpchoData> _listData;//设置列表数据
  InfoDetail({this.href,this.name});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(name,style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightBlue[500],
      ),
      body: new Center(

        child: _gridInfos(),
      ),
    );
  }


  Widget _gridInfos(){
    return Scaffold(
      body: ProgressDialog(
        loading: _loading,
        msg: '正在加载...',
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            mainAxisSpacing:10,
            crossAxisSpacing:20,
              childAspectRatio:2,
          ),
          itemCount: _listData==null?0:_listData.length,//此处 +1 是为了在最后添加一个progress
          itemBuilder: (content,index){
            return _listItem(index);
          },
        ),
      ),
    );
  }
  Future<Null> getHttp() async {
    try {
      Response response;
      response=await Dio().get("http://47.104.97.146:5000/anime?href="+href);
      //List responseJson = json.decode(response.data);
      AnimeDetail respResult = AnimeDetail.fromJson(response.data);
      setState(() {
        _listData=respResult.data;
      });
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Null> getTrueUrl(String url) async {
    try {
      Response response;
      response=await Dio().get("http://47.104.97.146:5000/playurl?href="+url);
      //List responseJson = json.decode(response.data);
      TrueUrl respResult = TrueUrl.fromJson(response.data);
      setState(() {
        true_url=respResult.href;
      });
    } catch (e) {
      print(e);
    }
    return null;
  }

  Widget _listItem(int index) {
    return new MaterialButton(
      color: Colors.blue,
      textColor: Colors.white,
      child: new Text(_listData[index].epcho),
      onPressed: () {
        // ...
        getTrueUrl(_listData[index].href).then((_){
          Navigator.push(context, MaterialPageRoute(builder: (cx)=>VideoScreen(url: true_url,)));
        });
      },
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
}
