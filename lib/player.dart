import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_player/util/player_ui.dart';

class VideoScreen extends StatefulWidget {
  final String url;

  VideoScreen({@required this.url});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final FijkPlayer player = FijkPlayer();

  _VideoScreenState();

  @override
  void initState() {
    super.initState();
    player.setDataSource(widget.url, autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(title: Text("Fijkplayer Example")),
        body: Container(
          alignment: Alignment.center,
          child: FijkView(
            player: player,
//            panelBuilder: (FijkPlayer player, BuildContext context, Size viewSize, Rect texturePos) {
//              return CustomFijkPanel(
//                  player: player,
//                  buildContext: context,
//                  viewSize: viewSize,
//                  texturePos: texturePos);
//            },
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}