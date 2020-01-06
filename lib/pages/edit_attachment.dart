import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter/models/view.dart';
import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';

class EditAttachmentPage extends StatefulWidget {
  List<FileAttach> file;
  List<Object> listNewupload ;

  EditAttachmentPage(this.file,this.listNewupload);

  @override
  _EditAttachmentPageState createState() => _EditAttachmentPageState();
}

class _EditAttachmentPageState extends State<EditAttachmentPage> {
  List <FileAttach>fileList = [];
  List<Object> _imageList = List<Object>();
  List<String> imageStorage = List<String>();
  bool upload = false;
  File imageObj;
  bool oldImage = false;

  @override
  void initState() {
    _imageList.clear();
    imageStorage.clear();
    if (widget.file != null) {
      widget.file.forEach((value) {
        fileList.add(FileAttach(id: value.id, url: value.url));
      });
      oldImage = true;
    }
    if (widget.listNewupload != null) {
      print('initNewUp ${widget.listNewupload.length}');
      widget.listNewupload.forEach((value) {
        _imageList.add(value);
      });
      oldImage = true;
      upload = true;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('editAttachment.title')),
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () async {
//            print(fileList.length);
//            fileList.forEach((v)=> print(v.id));
          print('oldFile ${fileList.length}');
          print('newFile ${_imageList.length}');
            Navigator.pop(context,
                {'imageList': _imageList, 'imageStorage': imageStorage,'fileAttach' : fileList});
//            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFFfa593f),
                const Color(0xFFfb9060),
              ]),
        ),
        height: MediaQuery.of(context).size.height,
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.09),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0)),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 30, top: 30),
                    alignment: Alignment.topLeft,
                    child: Text(
                      translate('editAttachment.subtitle'),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    height: 150,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: fileList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var length = fileList.length;

                        return length > 0
                            ? Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 3, left: 3),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            width: 120,
                                            height: 100,
                                            child: Image.network(
                                              fileList[index].url,
                                              fit: BoxFit.cover,
                                            )),
                                        Container(
                                          width: 120,
                                          height: 50,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0, left: 3),
                                                child: Text(
                                                    translate('editAttachment.picture') + '${index + 1}' ,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3.0,
                                                    left: 3,
                                                    bottom: 3),
                                                child: GestureDetector(
                                                  child: Text(
                                                    translate('editAttachment.delete'),
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Colors.grey[400]),
                                                  ),
                                                  onTap: () {
                                                    print('Delete $index');
                                                    fileList.removeAt(index);
                                                    if (fileList.length == 0) {
                                                      upload = false;
                                                    }
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(5.0),
                                                bottomRight:
                                                    Radius.circular(5.0)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(
                                height: 10,
                              );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  upload == false ? GestureDetector(
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      color: Colors.grey,
                      radius: Radius.circular(12),
                      padding: EdgeInsets.all(6),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            width: 250,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  translate('editAttachment.addPicture'),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                Text(
                                  translate('editAttachment.default'),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                )
                              ],
                            ),
                          )),
                    ),
                    onTap: () {
                      upload = !upload;
                      setState(() {});
                      _showSelectImageDialog();
                    },
                  ):
                  Container(
                    width: double.infinity,
                    height: 150,
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: _imageList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var length = _imageList.length;
                          print(length);
                          return length > 0 ? Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 3, left: 3),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        width: 120,
                                        height: 100,
                                        child: Image.file(
                                          _imageList[index],
                                          fit: BoxFit.cover,
                                        )),
                                    Container(
                                      width: 120,
                                      height: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0, left: 3),
                                            child: Text(
                                              translate('editAttachment.picture') + '${index + 1}' ,

                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.0, left: 3, bottom: 3),
                                            child: GestureDetector(
                                              child: Text(
                                                translate('editAttachment.delete'),
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey[400]),
                                              ),
                                              onTap: () {
                                                print('Delete $index');
                                                _imageList.removeAt(index);
                                                if (_imageList.length == 0) {
                                                  upload = false;
                                                }
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5.0),
                                            bottomRight: Radius.circular(5.0)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              length - 1 == index
                                  ? GestureDetector(
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        color: Colors.grey,
                                        radius: Radius.circular(12),
                                        padding: EdgeInsets.all(6),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            child: Container(
                                              width: 120,
                                              height: 150,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.grey,
                                                    size: 40,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    translate('editAttachment.addOther'),
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    translate('editAttachment.other'),
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                      onTap: () => _showSelectImageDialog(),
                                    )
                                  : SizedBox()
                            ],
                          ):GestureDetector(
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: Colors.grey,
                              radius: Radius.circular(12),
                              padding: EdgeInsets.all(6),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Container(
                                    width: 120,
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey,
                                          size: 40,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          translate('editAttachment.addOther'),
                                          style: TextStyle(
                                              color: Colors.grey,fontSize: 12),
                                        ),
                                        Text(
                                          translate('editAttachment.other'),
                                          style: TextStyle(
                                              color: Colors.grey,fontSize: 12),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            onTap: () => _showSelectImageDialog(),
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<File>> getImage(ImageSource source) async {
    var _imageBytes;
    var _imageBase64;
    Navigator.pop(context);
    var image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      _imageList.add(image);
      _imageBytes = image.readAsBytesSync();
      _imageBase64 = base64Encode(_imageBytes);
      imageStorage.add("data:image/jpeg;base64,$_imageBase64");
      setState(() {

      });
//      fileList
//          .add(FileAttach(id: '', url: "data:image/jpeg;base64,$_imageBase64"));
    }
    if(_imageList.length < 1){
      upload = false;
      setState(() {

      });
    }


  }

  void _showSelectImageDialog() {
    return Platform.isIOS ? _iosButtonSheet() : _androidDialog();
  }

  _iosButtonSheet() {
    print('ios');
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(translate('editAttachment.addPictures'),),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text(translate('editAttachment.takePicture')),
              onPressed: () => getImage(ImageSource.camera),
            ),
            CupertinoActionSheetAction(
              child: Text(translate('editAttachment.gallery')),
              onPressed: () => getImage(ImageSource.gallery),
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(translate('editAttachment.cancel')),
            onPressed: () {
              upload = false;
              setState(() {

              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  _androidDialog() {
    print('android');
    showDialog(
        context: context,
        builder: (BuildContext context) {

          return SimpleDialog(
            title: Text(translate('editAttachment.addPictures')),
            children: <Widget>[
              SimpleDialogOption(
                child: Text(translate('editAttachment.takePicture')),
                onPressed: () => getImage(ImageSource.camera),
              ),
              SimpleDialogOption(
                child: Text(translate('editAttachment.gallery')),
                onPressed: () => getImage(ImageSource.gallery),
              ),
              SimpleDialogOption(
                child: Text(
                  translate('editAttachment.cancel'),
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  upload = false;
                  setState(() {

                  });
                  Navigator.pop(context);



                },
              )
            ],
          );
        });
  }
}
