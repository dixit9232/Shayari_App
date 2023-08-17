import 'package:flutter/material.dart';
import 'package:shayri_app/Data.dart';
import 'package:shayri_app/Shayari_view.dart';

class Shayarilist extends StatefulWidget {
  int index;

  Shayarilist(this.index);

  State<Shayarilist> createState() => _ShayarilistState();
}

class _ShayarilistState extends State<Shayarilist> {
  List shayari = [];

  @override
  void initState() {
    if (widget.index == 0) {
      shayari = Data.motivationalshayari;
    } else if (widget.index == 1) {
      shayari = Data.lifeshayari;
    } else if (widget.index == 2) {
      shayari = Data.mohabbatshayari;
    } else if (widget.index == 3) {
      shayari = Data.yaadshayari;
    } else if (widget.index == 4) {
      shayari = Data.othershayari;
    } else if (widget.index == 5) {
      shayari = Data.rajnitishayari;
    } else if (widget.index == 6) {
      shayari = Data.premshayari;
    } else if (widget.index == 7) {
      shayari = Data.dardshayari;
    }
  }

  List<bool> temp = List.filled(8, false);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "${Data.shayariname[widget.index]}",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: ListView.builder(
        itemCount: shayari.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTapDown: (details) {
              temp[index] = true;
              Duration(microseconds:500);
              setState(() {});
            },
            onTapUp: (details) {
              temp[index] = false;
              Duration(microseconds:500);
              setState(() {});
            },
            onTapCancel: () {
              temp[index] = false;
              Duration(microseconds:500);
              setState(() {});
            },
            child: Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                tileColor: (temp[index] == true) ? Colors.blue : Colors.pinkAccent,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Shayari_View(index, shayari, widget.index);
                    },
                  ));
                },
                trailing:
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                leading: Container(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    "${Data.shayariimage[widget.index]}",
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text("${shayari[index]}",
                    maxLines: 1,
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}
