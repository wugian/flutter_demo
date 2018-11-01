import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wugian_flutter/video_player_lee.dart';

//void main() => runApp(new VideoApp("url"));
//void main() => runApp(new PT());
void main() => runApp(new MyApp());

class PT extends StatefulWidget {
  @override
  _PT createState() => new _PT();
}

class _PT extends State<PT> {
  List data;

  void _httpClient() async {
    var responseBody;

    var httpClient = new HttpClient();
    var request = await httpClient
        .getUrl(Uri.parse("http://api.hclyz.cn:81/mf/json.txt"));

    var response = await request.close();

    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();

      var convertDataToJson = jsonDecode(responseBody)["pingtai"];
      setState(() {
        data = convertDataToJson;
      });
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    _httpClient();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.black,
        body: new Center(
          child: new GridView.count(
            children: data != null ? _getItem() : _loading(),
            crossAxisCount: 3,
          ),
        )
//      body:
        );
  }

  List<Widget> _loading() {
    return <Widget>[
      new Container(
        height: 300.0,
        child: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              strokeWidth: 1.0,
            ),
            new Text("loading......"),
          ],
        )),
      )
    ];
  }

  List<Widget> _getItem() {
    return data.map((item) {
      return new Center(
        child: new Padding(
          padding: const EdgeInsets.all(1.0),
          child: _getRowWidget(item),
        ),
//        elevation: 3.0,
//        margins: const EdgeInsets.all(1.0),
      );
    }).toList();
  }

  Widget _getRowWidget(item) {
    return new GestureDetector(
        onTap: () {
          print(item.toString());
          Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
            return new MyHomePage(
              title: item["address"],
            );
          }));
        },
        child: new Row(
          children: <Widget>[
            new Center(
              child: new Stack(
                children: <Widget>[
//                  new Text("${item['title']}",),
                  new FadeInImage.assetNetwork(
                    placeholder:
                        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536774923506&di=2a3e4d720505d32d4c569220856abb0d&imgtype=0&src=http%3A%2F%2F06.imgmini.eastday.com%2Fmobile%2F20180724%2F20180724224829_40f964a0b352223127c92a66e6b14054_3.jpeg",
                    image: "${item['xinimg']}",
                    width: 114.0,
                    height: 114.0,
                    fit: BoxFit.fitHeight,
                  ),
                  new Positioned(
                    left: 1.0,
                    right: 1.0,
                    bottom: 5.0,
                    child: new Text(
                      "${item['title']}",
                      textAlign: TextAlign.center,
                      style: new TextStyle(fontSize: 14.0, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          primarySwatch: Colors.blue, backgroundColor: Colors.black),
      home: new PT(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data;

  void _httpClient() async {
    var responseBody;

    var httpClient = new HttpClient();
    var request = await httpClient
//        .getUrl(Uri.parse("http://api.hclyz.cn:81/mf/jsondaxiaojie.txt"));
        .getUrl(Uri.parse("http://api.hclyz.cn:81/mf/" + widget.title));

    var response = await request.close();

    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();

      var convertDataToJson = jsonDecode(responseBody)["zhubo"];
      setState(() {
        data = convertDataToJson;
      });
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    _httpClient();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        body: new GridView.count(
          children: data != null ? _getItem() : _loading(),
          crossAxisCount: 3,
        ),
        backgroundColor: Colors.black);
  }

  List<Widget> _loading() {
    return <Widget>[
      new Container(
        height: 300.0,
        child: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              strokeWidth: 1.0,
            ),
            new Text("loading......"),
          ],
        )),
      )
    ];
  }

  List<Widget> _getItem() {
//    return data.map((item) {
//      return new Center(
//        child: new Padding(
//          padding: const EdgeInsets.all(1.0),
//          child: _getRowWidget(item),
//        ),
////        elevation: 3.0,
////        margins: const EdgeInsets.all(1.0),
//      );
//    }).toList();
    return data.map((item) {
      return new Center(
        child: new Padding(
          padding: const EdgeInsets.all(1.0),
          child: _getRowWidget(item),
        ),
//        elevation: 3.0,
//        margin: const EdgeInsets.all(1.0),
      );
    }).toList();
  }

  Widget _getRowWidget(item) {
    return new GestureDetector(
        onTap: () {
          print(item.toString());
          Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
            return new SecondPage(
              title: item["address"],
            );
          }));
        },
        child: new Row(
          children: <Widget>[
            new Center(
              child: new Stack(
                children: <Widget>[
//                  new Text("${item['title']}",),
                  new FadeInImage.assetNetwork(
                    placeholder:
                        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536774923506&di=2a3e4d720505d32d4c569220856abb0d&imgtype=0&src=http%3A%2F%2F06.imgmini.eastday.com%2Fmobile%2F20180724%2F20180724224829_40f964a0b352223127c92a66e6b14054_3.jpeg",
                    image: "${item['img']}",
                    width: 114.0,
                    height: 100.0,
                    fit: BoxFit.fitHeight,
                  ),
                  new Positioned(
                    left: 1.0,
                    right: 1.0,
                    bottom: 5.0,
                    child: new Text(
                      "${item['title']}",
                      textAlign: TextAlign.center,
                      style: new TextStyle(fontSize: 14.0, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
//        child: new Row(
//          children: <Widget>[
//            new Center(
//              child: new FadeInImage.assetNetwork(
//                placeholder:
//                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536774923506&di=2a3e4d720505d32d4c569220856abb0d&imgtype=0&src=http%3A%2F%2F06.imgmini.eastday.com%2Fmobile%2F20180724%2F20180724224829_40f964a0b352223127c92a66e6b14054_3.jpeg",
//                image: "${item['img']}",
//                width: 90.0,
//                height: 90.0,
//                fit: BoxFit.fitWidth,
//              ),
//            ),
//          ],
//        ));
  }
}

class SecondPage extends StatefulWidget {
  SecondPage({this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return new SecondState();
  }
}

class SecondState extends State<SecondPage> {
  VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.title)
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
//        floatingActionButton: FloatingActionButton(
//          onPressed: _controller.value.isPlaying
//              ? _controller.pause
//              : _controller.play,
////        onPressed: widget.dispose(),
//          child: Icon(
//            Icons.arrow_back,
//          ),
//        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
