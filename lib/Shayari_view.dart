import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shayri_app/Data.dart';
import 'package:shayri_app/Finalpage.dart';


class Shayari_View extends StatefulWidget {
  int index;
  List shayari;
  int pos;

  Shayari_View(
    this.pos,
    this.shayari,
    this.index,
  );

  State<Shayari_View> createState() => _Shayari_ViewState();
}

class _Shayari_ViewState extends State<Shayari_View> {
  PageController controller = PageController();
  int r = 0;
  bool temp = true;

  initState() {
    controller = PageController(initialPage: widget.pos);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${Data.shayariname[widget.index]}",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return GridView.builder(
                            itemCount: Data.grediantcolor.length - 3,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  temp = false;
                                  r = index;
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
                                      Data.grediantcolor[index + 3]
                                    ]))),
                              );
                            },
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.swap_horiz),
                    iconSize: 30,
                    hoverColor: Colors.blue,
                    splashColor: Colors.blue),
                Text("${widget.pos + 1}/${widget.shayari.length}",
                    style: TextStyle(fontSize: 20)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        r = Random().nextInt(12);
                        temp = false;
                      });
                    },
                    icon: Icon(Icons.cached_rounded),
                    iconSize: 30,
                    hoverColor: Colors.blue,
                    splashColor: Colors.blue)
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Flexible(
            flex: 5,
            child: PageView.builder(
              onPageChanged: (value) {
                widget.pos = value;
                setState(() {});
              },
              controller: controller,
              itemCount: widget.shayari.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: (temp == true) ? Colors.pinkAccent : null,
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
                  height: 500,
                  child: Text(
                    "${widget.shayari[index]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 200,
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                            text: "${widget.shayari[widget.pos]}"));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Text Copied")));
                      },
                      icon: Icon(Icons.copy),
                      iconSize: 30,
                      hoverColor: Colors.blue,
                      splashColor: Colors.blue),
                  IconButton(
                      onPressed: () {
                        if (widget.pos > 0) {
                          widget.pos--;
                          controller.jumpToPage(widget.pos);
                          setState(() {});
                        }
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                      iconSize: 30,
                      hoverColor: Colors.blue,
                      splashColor: Colors.blue),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return FinalPage(
                                widget.shayari, widget.pos, widget.index);
                          },
                        ));
                      },
                      icon: Icon(Icons.edit),
                      iconSize: 30,
                      hoverColor: Colors.blue,
                      splashColor: Colors.blue),
                  IconButton(
                      onPressed: () {
                        if (widget.pos < widget.shayari.length - 1) {
                          widget.pos++;
                          controller.jumpToPage(widget.pos);
                          setState(() {});
                        }
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                      iconSize: 30,
                      hoverColor: Colors.blue,
                      splashColor: Colors.blue),
                  IconButton(
                      onPressed: () {
                        Share.share("${widget.shayari[widget.pos]}");
                        setState(() {});
                      },
                      icon: Icon(Icons.share),
                      iconSize: 30,
                      hoverColor: Colors.blue,
                      splashColor: Colors.blue),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
