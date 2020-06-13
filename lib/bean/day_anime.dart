import 'dart:convert' show json;

class DayTotal {

  List<DayData> data;

  DayTotal.fromParams({this.data});

  factory DayTotal(jsonStr) => jsonStr == null ? null : jsonStr is String ? new DayTotal.fromJson(json.decode(jsonStr)) : new DayTotal.fromJson(jsonStr);

  DayTotal.fromJson(jsonRes) {
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new DayData.fromJson(dataItem));
    }
  }

}

class DayData {

  int id;
  bool isnew;
  String mtime;
  String name;
  String namefornew;
  int wd;

  DayData.fromParams({this.id, this.isnew, this.mtime, this.name, this.namefornew, this.wd});

  DayData.fromJson(jsonRes) {
    id = jsonRes['id'];
    isnew = jsonRes['isnew'];
    mtime = jsonRes['mtime'];
    name = jsonRes['name'];
    namefornew = jsonRes['namefornew'];
    wd = jsonRes['wd'];
  }
}

