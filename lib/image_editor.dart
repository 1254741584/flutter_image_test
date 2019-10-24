import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'dart:io';

import 'crop_editor_helper.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'custom_screen_dimens.dart';
import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ImageEditorPage  extends StatefulWidget{
  File file;

  ImageEditorPage(this.file);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImageEditorPageState(this.file);
  }
}

class _ImageEditorPageState extends State<ImageEditorPage>{
  final GlobalKey<ExtendedImageEditorState> editorKey =GlobalKey<ExtendedImageEditorState>();


  _ImageEditorPageState(this.file);
  File file;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                margin: EdgeInsets.only(
                    left: CustomScreenDimens.marginSizeS4,
                    right: CustomScreenDimens.marginSizeS4,
                    bottom: CustomScreenDimens.marginSizeS2,
                    top: CustomScreenDimens.marginSizeS4,
                ),
                width: MediaQuery.of(context).size.width,
                height: CustomScreenDimens.baseHeight * 100,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          child: FlatButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, child: Text("取消")),
                        ),
                        onTap: (){
//                        Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          child: FlatButton(
                              onPressed: () async{
                                if (isClick) {
                                  return;
                                }
                                isClick = true;
                                File src = await getImage();
                                Navigator.of(context).pop(src);
                              },
                              child: Text("确定")),
                        ),
                        onTap: () async{
//                        if (isClick) {
//                          return;
//                        }
//                        isClick = true;
//                        image.Image src = await getImage();
//                        Navigator.of(context).pop(src);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              left: 0,
              bottom: 0,
            ),
            Container(
              height: MediaQuery.of(context).size.height - CustomScreenDimens.baseHeight * 100,
              child: ExtendedImage.file(
                file,
                fit: BoxFit.contain,
                mode: ExtendedImageMode.editor,
                extendedImageEditorKey: editorKey,
                initEditorConfigHandler: (state) {
                  return EditorConfig(
                    maxScale: 8.0,
                    cropRectPadding: EdgeInsets.all(CustomScreenDimens.marginSizeS4),
                    hitTestSize: 20.0,
//                cropAspectRatio: CropAspectRatios.ratio1_1
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    print("页面销毁");
    super.dispose();
  }

  bool isClick = false;

  getImage() async{

    Uint8List fileData = await cropImageDataWithNativeLibrary(state: editorKey.currentState);
    var fileFath = await ImagePickerSaver.saveFile(fileData: fileData);
    return File(fileFath);


//    DateTime startTime = DateTime.now();
//    var cropRect = editorKey.currentState.getCropRect();
//    ui.Image imageData = editorKey.currentState.image;
//    DateTime getImageTime = DateTime.now();
//    print("getImageTime===${getImageTime.difference(startTime)}");
//    var data = await imageData.toByteData(format: ui.ImageByteFormat.png);
//    DateTime toByteDataTime = DateTime.now();
//    print("data.lengthInBytes===${data.lengthInBytes}");
//    print("toByteDataTime===${toByteDataTime.difference(getImageTime)}");
//    image.Image src = image.decodePng(data.buffer.asUint8List());
//
//    DateTime decodePngTime = DateTime.now();
//    print("decodePngTime===${decodePngTime.difference(toByteDataTime)}");
//
//    var cropData = image.copyCrop(src, cropRect.left.toInt(), cropRect.top.toInt(),
//        cropRect.width.toInt(), cropRect.height.toInt());
//
//    image.encodePng(cropData, level: 1);
//    String path = await StaticDatautils.getAppDocPath();
//
//    File file = File("${path}/temp_image_${DateTime.now().millisecondsSinceEpoch}.png");
//    await file.writeAsBytes(image.encodePng(cropData));
//
//    return file;
//    return File.fromRawPath(image.encodePng(cropData));

//    return image.decodePng(data.buffer.asUint8List());
  }



}