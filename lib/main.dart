import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shayri_app/Data.dart';
import 'package:shayri_app/ShayariList.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Shayariapp(),
  ));
}

class Shayariapp extends StatefulWidget {
  const Shayariapp({super.key});

  @override
  State<Shayariapp> createState() => _ShayariappState();
}

class _ShayariappState extends State<Shayariapp> {
  List<bool> temp = List.filled(8, false);

  @override
  void initState() {
    fun();
  }

  fun() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    var status = await Permission.storage.request();
    var status1 = await Permission.photos.request();
    if (Platform.isAndroid) {
      AndroidDeviceInfo android = await plugin.androidInfo;
      if (android.version.sdkInt < 33) {
        if (status.isDenied) {
          Permission.storage.request();
          if(status.isDenied)
            {
              openAppSettings();
            }
        }
        if (status.isPermanentlyDenied) {
          openAppSettings();
        }
      } else if (android.version.sdkInt > 33) {
        if (status1.isDenied) {
          Permission.photos.request();
          if(status1.isDenied)
            {
              openAppSettings();
            }
        }
        if (status1.isPermanentlyDenied) {
          openAppSettings();
        }
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Mehfil-e-Shayari",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: ListView.builder(
        itemCount: Data.shayariname.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTapUp: (details) {
              temp[index] = false;
              Duration(microseconds: 500);
              setState(() {});
            },
            onTapCancel: () {
              temp[index] = false;
              Duration(microseconds: 500);
              setState(() {});
            },
            onTapDown: (details) {
              temp[index] = true;
              Duration(microseconds: 500);
              setState(() {});
            },
            child: Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                tileColor: (temp[index] == true) ? Colors.blue : null,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Shayarilist(index);
                    },
                  ));
                },
                leading: Container(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    "${Data.shayariimage[index]}",
                    fit: BoxFit.fill,
                  ),
                ),
                horizontalTitleGap: 20,
                title: Text(
                  "${Data.shayariname[index]}",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
