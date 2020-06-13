import 'package:dio/dio.dart';

class HttpUtil{

  static HttpUtil httpUtil;
  String baseUrl="https://guangdiu.com/api/";
  Dio dio;
  BaseOptions options;

  static HttpUtil getInstance(){
    if(httpUtil==null){
      httpUtil=HttpUtil();
    }
    return httpUtil;
  }

  HttpUtil(){
    options=BaseOptions(
        baseUrl:baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 3000,
        headers: {}
    );
    dio=Dio(options);
  }

  // ignore: avoid_init_to_null
  Future<Response> get(String url,{options,callBack,data}) async {
    print("--------  $url  --------");
    Response response;
    try{
      response=await dio.get(
        url,
      );
      print("--------   " + response.toString());
      return response;
    }on DioError catch(e){
      if(CancelToken.isCancel(e)){
        print("取消 "+e.message);
      }else{
        print(e);
      }
      return null;
    }
  }


  Future<Response>  post(String url,{options,callBack,data}) async {
    print("*********  $url  *************");
    Response response;
    try{
      response=await dio.post(
          url,
          data: data,
          cancelToken: callBack,
          options: options
      );
      return response;
    }on DioError catch(e){
      if(CancelToken.isCancel(e)){
        print("取消 "+e.message);
      }else{
        print(e);
      }
      return null;
    }
  }

}