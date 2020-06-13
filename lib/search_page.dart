import 'package:flutter/material.dart';

const searchList = [
  'jiejie-大长腿',
  'jiejie-水蛇腰',
  'gege-帅气欧巴',
  'gege-小鲜肉'
];

const recentSuggest = [
  '推荐-1',
  '推荐-2',
];

class SearchBarDelegate extends SearchDelegate<String>{
  //清空按钮
  @override
  List<Widget>buildActions(BuildContext context){
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "", //搜索值为空
      )
    ];
  }
  //返回上级按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation
        ),
        onPressed: () => close(context, null)  //点击时关闭整个搜索页面
    );
  }
  //搜到到内容后的展现
  @override
  Widget buildResults(BuildContext context){
    return Container(
      width: 100.0,
      height:100.0,
      child: Card(
        color:Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }
  //设置推荐
  @override
  Widget buildSuggestions(BuildContext context){
    final suggestionsList= query.isEmpty
        ? recentSuggest
        : searchList.where((input)=> input.startsWith(query)).toList();

    return ListView.builder(
      itemCount:suggestionsList.length,
      itemBuilder: (context,index) => ListTile(
        title: RichText( //富文本
          text: TextSpan(
              text: suggestionsList[index].substring(0,query.length),
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionsList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey)
                )
              ]
          ),
        ),
      ),
    );
  }

//  FutureBuilder<Null> buildSearchFutureBuilder(String key) {
//    return new FutureBuilder<Null>(
//      builder: (context, AsyncSnapshot<Null> async) {
//        if (async.connectionState == ConnectionState.active ||
//            async.connectionState == ConnectionState.waiting) {
//          return new Center(
//            child: new CircularProgressIndicator(),
//          );
//        }
//
//        if (async.connectionState == ConnectionState.done) {
//          debugPrint('done');
//          if (async.hasError) {
//            return new Center(
//              child: new Text('Error:code '),
//            );
//          } else if (async.hasData) {
//            HomeBean bean = async.data;
//            return new ArticleListView(
//                bean.data.datas, ArticleType.NORMAL_ARTICLE, null);
//          }
//        }
//      },
//      future: getSearchData(key),
//    );
//  }
}