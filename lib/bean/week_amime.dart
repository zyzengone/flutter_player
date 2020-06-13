import 'dart:convert' show json;

class RespResult {

  List<RstData> data;

  RespResult.fromParams({this.data});

  factory RespResult(jsonStr) => jsonStr == null ? null : jsonStr is String ? new RespResult.fromJson(json.decode(jsonStr)) : new RespResult.fromJson(jsonStr);

  RespResult.fromJson(jsonRes) {
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new RstData.fromJson(dataItem));
    }
  }

}

class RstData {

  int id;
  bool isnew;
  String img;
  String href;
  String mtime;
  String name;
  String namefornew;
  int wd;

  RstData.fromParams({this.id, this.isnew, this.img,this.href,this.mtime, this.name, this.namefornew, this.wd});

  RstData.fromJson(jsonRes) {
    id = jsonRes['id'];
    isnew = jsonRes['isnew'];
    mtime = jsonRes['mtime'];
    name = jsonRes['name'];
    namefornew = jsonRes['namefornew'];
    wd = jsonRes['wd'];
    img = jsonRes['img'];
    href = jsonRes['href'];
  }
}

