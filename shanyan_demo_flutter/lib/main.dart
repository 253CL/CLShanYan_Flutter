import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  static const platform = const MethodChannel('shanyan.flutter.quickLogin');

  String _shanyanloginStutas = "";
  String _phoneNumber = "";

  Future<void> _shanyanLogin() async {

    /*
    * shanyanQuicklogin :与ShanYanManager.m中 -(void)handleMethodCall* 方法内保持一致*/

    //OC调flutter
    platform.setMethodCallHandler((MethodCall call) async {
      if(call.method == "shanyanQuickloginCallBack") {

        _phoneNumber = "登录成功，oc内部解密手机号成功： ${call.arguments["phoneNumber"]}";
        _shanyanloginStutas = "sdk获取token成功，原始数据: ${call.arguments["data"].toString()}";

        setState(() {
        });
      }
    });

    try {
      _shanyanloginStutas = '等待获取号码。。。';
      //flutter调OC
      final result = await platform.invokeMethod('shanyanQuicklogin',{
        "iOS":{
          "test":"测试传参给原生，无实际作用",
        }
      });
      print(result.toString());
    } on PlatformException catch (e) {
      _shanyanloginStutas = "一键登录失败: '${e.toString()}'.";
    }

//    Fluttertoast.showToast(
//        msg: _shanyanloginStutas,
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.CENTER,
//        timeInSecForIos: 1,
//        backgroundColor: Colors.blueGrey,
//        textColor: Colors.deepOrange
//    );

    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Text('闪验一键登录'),
              onPressed: _shanyanLogin,
            ),
            Text(_shanyanloginStutas),
            Text(_phoneNumber),
          ],
        ),
      ),
    );
  }
}
