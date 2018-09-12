import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wugian_flutter/video_player_lee.dart';
//import 'package:video_player/video_player.dart';

//void main() => runApp(new VideoApp("url"));
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'WUGIAN'),
    );
  }
}

var id = 0;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 100;
  List data;

  void _pullNet() async {
    await http
        .get("http://www.wanandroid.com/project/list/1/json?cid=1")
        .then((http.Response response) {
      var convertDataToJson = JSON.decode(response.body);
      convertDataToJson = convertDataToJson["data"]["datas"];

      print(convertDataToJson);

      setState(() {
        data = convertDataToJson;
      });
      convertDataToJson.forEach((item) {
        print(item["envelopePic"]);
      });
    });
  }

  void _httpClient() async {
    var responseBody;

    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(
        Uri.parse("http://www.wanandroid.com/project/list/1/json?cid=1"));

    var response = await request.close();

    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();

      var convertDataToJson = jsonDecode(responseBody)["data"]["datas"];
      setState(() {
        data = convertDataToJson;
      });

      convertDataToJson.forEach((item) {
        print("***********************");
        print(item["envelopePic"]);
        print("***********************");
      });
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    _pullNet();
//    _httpClient();
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(children: data != null ? _getItem() : _loading()),
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
            new Text("正在加载"),
          ],
        )),
      )
    ];
  }

  List<Widget> _getItem() {
    return data.map((item) {
      return new Card(
        child: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: _getRowWidget(item),
        ),
        elevation: 3.0,
        margin: const EdgeInsets.all(10.0),
      );
    }).toList();
  }

  Widget _getRowWidget(item) {
    return new GestureDetector(
        onTap: () {
          print(item.toString());
//          Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
//            return new SecondPage(title: data["envelopePic"]);
//          }));
          id = (id == 0 ? 1 : 0);
          Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
//            return new VideoApp(data[0]["envelopePic"]);
            return new SecondPage(
              title: data[0]["envelopePic"],
            );
          }));
        },
        child: new Row(
          children: <Widget>[
            new Flexible(
                flex: 1,
                fit: FlexFit.tight, //和android的weight=1效果一样
                child: new Stack(
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new Text("${item["title"]}".trim(),
                            style: new TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.left),
                        new Text(
                          "${item["desc"]}",
                          maxLines: 3,
                        )
                      ],
                    ),
                  ],
                )),
            new ClipRect(
              child: new FadeInImage.assetNetwork(
                placeholder: "images/ic_shop_normal.png",
                image: "${item['envelopePic']}",
                width: 50.0,
                height: 50.0,
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ));

//    return
  }
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(widget.title),
//      ),
//      body: new ListView.builder(
//        itemCount: data.length,
//        itemBuilder: (context, index) {
//          return new ListTile(
//            title: new Text('${data[index]["desc"]}'),
//          );
//        },
//      ),
////      body: new Center(
////
////        child: new ListView(
//////          mainAxisAlignment: MainAxisAlignment.center,
////          padding: new EdgeInsets.all(10.0),
////          children: <Widget>[
////            new Center(
////              child: new Text(
////                'You have pushed the button this many times:',
////              ),
////            ),
////            new Center(
////              child: new Text(
////                '$_counter',
////                style: Theme.of(context).textTheme.display1,
////              ),
////            ),
////            new Container(
////              padding: new EdgeInsets.only(top: 10.0),
////              width: 86.0,
////              height: 48.0,
////              child: new MaterialButton(
////                elevation: 12.0,
////                color: Colors.greenAccent,
////                splashColor: Colors.green,
////                onPressed: _decrementCounter,
////                child: new Text("minus"),
////              ),
////            ),
////            new Container(
////              padding: new EdgeInsets.only(top: 10.0),
////              width: 86.0,
////              height: 48.0,
////              child: new MaterialButton(
////                elevation: 12.0,
////                minWidth: 80.0,
////                color: Colors.greenAccent,
////                splashColor: Colors.green,
////                onPressed: _incrementCounter,
////                child: new Text("add"),
////              ),
////            ),
////            new Container(
////              padding: new EdgeInsets.only(top: 10.0),
////              child: new Image.network(
////                "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3573075543,1312702639&fm=27&gp=0.jpg",
////                width: 400.0,
////                height: 400.0,
////              ),
////            ),
////            new Container(
//////                child: new ListView.builder(
//////              itemCount: items.length,
//////              itemBuilder: (context, index) {
//////                return new ListTile(
//////                  title: new Text('${items[index]}'),
//////                );
//////              },
//////            )
////                ),
//
////            new ListView.builder(itemBuilder: (context, index) {
////              return new ListTile(title: new Text("bbbb"));
////            })
////      ],
////    ),)
////    ,
//
////      floatingActionButton: new FloatingActionButton(
////        onPressed: _incrementCounter,
////        tooltip: 'Increment',
////        child: new Icon(Icons.exposure_neg_1),
////      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
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

    print("════════════════════════");
    print('${widget.title != null ? widget.title : ''}');
    print("════════════════════════");
    id = 0;
    _controller = VideoPlayerController.network(
      id == 0
          ? 'http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_20mb.mp4'
          : 'rtmp://live.hkstv.hk.lxdns.com/live/hks',
    )
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
//        _controller.play;
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
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
        floatingActionButton: FloatingActionButton(
          onPressed: _controller.value.isPlaying
              ? _controller.pause
              : _controller.play,
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }
}
