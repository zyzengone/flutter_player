import 'dart:convert' show json;

class AnimeDetail {

  List<EpchoData> data;

  AnimeDetail.fromParams({this.data});

  factory AnimeDetail(jsonStr) => jsonStr == null ? null : jsonStr is String ? new AnimeDetail.fromJson(json.decode(jsonStr)) : new AnimeDetail.fromJson(jsonStr);

  AnimeDetail.fromJson(jsonRes) {
    data = jsonRes['1'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['1']){
      data.add(dataItem == null ? null : new EpchoData.fromJson(dataItem));
    }
  }

}

class EpchoData {


  String epcho;
  String href;


  EpchoData.fromParams({this.epcho, this.href});

  EpchoData.fromJson(jsonRes) {
    epcho = jsonRes['epcho'];
    href = jsonRes['title'];
  }
}

