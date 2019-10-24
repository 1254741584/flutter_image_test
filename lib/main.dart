import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart' as singleimagePicker;
import 'image_editor.dart';
import 'custom_screen_dimens.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  File file;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: RaisedButton(onPressed: () async{
                PermissionStatus status = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
                if (status != PermissionStatus.granted) {
                  Map<PermissionGroup, PermissionStatus> permissions =
                  await PermissionHandler().requestPermissions([PermissionGroup.camera]);
                  PermissionStatus permissionStatus = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
                  print(permissions);
                  print(permissionStatus);
                  if (permissionStatus != PermissionStatus.granted) {
                    return;
                  }
                }

                if(Platform.isIOS){
                  //ios相关代码
                }else if(Platform.isAndroid){
                  print(status);
                  status = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
                  print(status);
                  if (status != PermissionStatus.granted) {
                    Map<PermissionGroup, PermissionStatus> permissions =
                    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
                    PermissionStatus permissionStatus = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
                    print(permissions);
                    print(permissionStatus);
                    if (permissionStatus != PermissionStatus.granted) {
                      return;
                    }
                  }
                }
                File image = await singleimagePicker.ImagePicker.pickImage(source: singleimagePicker.ImageSource.camera);
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new ImageEditorPage(image);
                })).then((res){
                  if (res ==null) {
                    return;
                  }
                  setState(() {
                  file = res;
                });});
                }, child: Text("拍照"),),
            ),
            file ==null?Container():Container(
              margin: EdgeInsets.only(left: CustomScreenDimens.marginSizeS1, right: CustomScreenDimens.marginSizeS1),
              constraints: BoxConstraints(
                  maxWidth: (MediaQuery.of(context).size.width - CustomScreenDimens.marginSizeS2 * 5 - CustomScreenDimens.marginSizeS4) / 3
              ),
              alignment: Alignment.center,
              child: Image.file(
                  file
              ),
            ),
          ],
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
