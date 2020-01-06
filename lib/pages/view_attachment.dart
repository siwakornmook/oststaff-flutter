import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:starter/models/view.dart';

class ViewAttachmentPage extends StatefulWidget {
  final List<FileAttach> fileAttach;

  ViewAttachmentPage(this.fileAttach);

  @override
  _ViewAttachmentPageState createState() => _ViewAttachmentPageState();
}

class _ViewAttachmentPageState extends State<ViewAttachmentPage> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(translate('viewAttach.title')),
        backgroundColor: Color(0xFFfa593f),
        elevation: 0.0,
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
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0)),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: CarouselSlider(
                  viewportFraction: 0.9,
                  aspectRatio: 1.5,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index) {
                    index = index;
                  },
                  items: widget.fileAttach.map((url) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: Image.network(
                              url.url,
                              fit: BoxFit.cover,
                              width: 500.0,
                              height: 200,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
