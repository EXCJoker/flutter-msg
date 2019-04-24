import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  static const CHANNEL = "com.example/msgdemo";

  //获取到插件与原生的交互通道
  static const jumpPlugin = const MethodChannel(CHANNEL);

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: () {
              jumpToNative();
            }, child: Text("跳转native"),),
            RaisedButton(onPressed: () {
              jumpToNativeWithParams();
            }, child: Text("跳转native - 带参数")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void jumpToNative() async {
    String result = await jumpPlugin.invokeMethod('oneAct');

    print(result);
  }

  void jumpToNativeWithParams() async {
    Map<String, String> map = { "flutter": "这是一条来自flutter的参数"};

    String result = await jumpPlugin.invokeMethod('twoAct', map);

    print(result);
  }
}
