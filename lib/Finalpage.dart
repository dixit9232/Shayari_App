import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayri_app/Data.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:external_path/external_path.dart';

class FinalPage extends StatefulWidget {
  List shayari;
  int pos;
  int index;

  FinalPage(this.shayari, this.pos, this.index);

  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  bool temp = true, col = true, tcol = true;
  int r = 0, c = 0, tc = 0;
  double a = 20;
  String emoji = " ", font = "";
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "${Data.shayariname[widget.index]}",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: WidgetsToImage(
                      child: Container(
                        decoration: BoxDecoration(
                          color: (col == true)
                              ? Colors.red
                              : (col == false)
                                  ? Data.grediantcolor[c]
                                  : null,
                          gradient: (temp == false)
                              ? LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                      Data.grediantcolor[r],
                                      Data.grediantcolor[r + 1],
                                      Data.grediantcolor[r + 2],
                                      Data.grediantcolor[r + 3],
                                    ])
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Text(
                            "${emoji}\n${widget.shayari[widget.pos]}\n${emoji}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: font,
                                fontSize: a,
                                color: (tcol == true)
                                    ? Colors.white
                                    : (tcol == false)
                                        ? Data.grediantcolor[tc]
                                        : null),
                          ),
                        ),
                      ),
                      controller: controller),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
          ),
          Expanded(
            child: Container(
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return GridView.builder(
                                  itemCount: Data.grediantcolor.length - 3,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        r = index;
                                        temp = false;
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.centerRight,
                                                end: Alignment.centerLeft,
                                                colors: [
                                              Data.grediantcolor[index],
                                              Data.grediantcolor[index + 1],
                                              Data.grediantcolor[index + 2],
                                              Data.grediantcolor[index + 3],
                                            ])),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.swap_horiz),
                          iconSize: 30,
                          color: Colors.black,
                          hoverColor: Colors.blue,
                          splashColor: Colors.blue),
                      SizedBox(
                        width: 50,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              r = Random().nextInt(12);
                              temp = false;
                            });
                          },
                          icon: Icon(Icons.cached_rounded),
                          iconSize: 30,
                          color: Colors.black,
                          hoverColor: Colors.blue,
                          splashColor: Colors.blue),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Container(
                                  height: 250,
                                  width: 300,
                                  child: GridView.builder(
                                    itemCount: Data.grediantcolor.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 5,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            c = index;
                                            temp = true;
                                            col = false;
                                            setState(() {});
                                          },
                                          child: Container(
                                            color: Data.grediantcolor[index],
                                          ));
                                    },
                                  ));
                            },
                          );
                        },
                        child: Container(
                            height: 30,
                            width: 120,
                            alignment: Alignment.center,
                            child: Text("Background",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            color: Colors.red),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 250,
                                width: 300,
                                child: GridView.builder(
                                  itemCount: Data.grediantcolor.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        tc = index;
                                        tcol = false;
                                        setState(() {});
                                      },
                                      child: Container(
                                        color: Data.grediantcolor[index],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 120,
                          alignment: Alignment.center,
                          child: Text("Text Color",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          color: Colors.red,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          bytes = await controller.capture();
                          var path = await ExternalPath
                                  .getExternalStoragePublicDirectory(
                                      ExternalPath.DIRECTORY_DOWNLOADS) +
                              "/My Shayari Image";
                          int r = Random().nextInt(100);
                          String img_name = "My Shayari Image ${r}.jpeg";
                          Directory dir = Directory(path);
                          if (!await dir.exists()) {
                            dir.create();
                          }
                          File f = File("${dir.path}/${img_name}");
                          f.writeAsBytes(bytes!);
                          Share.shareFiles(["${f.path}"]);
                        },
                        child: Container(
                          height: 30,
                          width: 120,
                          alignment: Alignment.center,
                          child: Text("Share",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(barrierColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 200,
                                child: ListView.builder(
                                  itemCount: Data.Font.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(tileColor: Colors.blue,
                                      onTap: () {
                                        font = Data.Font[index];
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      title: Text("${Data.Font[index]}"),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                            height: 30,
                            width: 120,
                            alignment: Alignment.center,
                            child: Text("Font",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            color: Colors.red),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(barrierColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 100,
                                child: ListView.builder(
                                  itemCount: Data.Emoji.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        emoji = Data.Emoji[index];
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      title: Text("${Data.Emoji[index]}"),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 120,
                          alignment: Alignment.center,
                          child: Text("Emoji",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          color: Colors.red,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Container(
                                  height: 100,
                                  child: StatefulBuilder(
                                    builder: (context, setState1) {
                                      return Slider(
                                        activeColor:
                                            CupertinoColors.activeOrange,
                                        inactiveColor:
                                            CupertinoColors.activeBlue,
                                        min: 10,
                                        max: 100,
                                        value: a,
                                        onChanged: (value) {
                                          a = value;
                                          setState1(() {});
                                          setState(() {});
                                        },
                                      );
                                    },
                                  ));
                            },
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 120,
                          alignment: Alignment.center,
                          child: Text("Text Size",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
