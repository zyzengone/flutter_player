import 'package:flutter/material.dart';
import 'package:flutter_player/bean/week_amime.dart';


class IndexItem extends StatelessWidget {

  RstData rstData;

  IndexItem({this.rstData}) :assert(rstData != null); //参数rstData必填且不为空

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _listItem(this.rstData);
  }

  Widget _listItem(RstData rstdata) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: 250,
            margin: EdgeInsets.all(1),//设置图片的边距
            child: Image.network("http:"+rstdata.img),
          ),
          Expanded(
            child: Container(
              child: Text(rstdata.name),
            ),
          )
        ],
      ),
    );
  }
}