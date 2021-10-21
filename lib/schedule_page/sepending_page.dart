
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';

class RepairPage extends StatefulWidget {
  @override
  _RepairPageState createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {
  var pickeddate;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    getDate().then((value){
      setState(() {
        pickeddate = value;
      });
    });
  }

  getDate() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString('String');
  }

  void _incrementCounter() async {
    final SharedPreferences  prefs = await SharedPreferences.getInstance();
    setState(() {
      DatePicker.showDatePicker(
          context,
          theme: DatePickerTheme(
            backgroundColor: Theme.of(context).primaryColor,
            itemStyle: TextStyle(
              color: Theme.of(context).primaryColorDark,
            ),
            doneStyle: TextStyle(
              color: Theme.of(context).primaryColorDark,
            ),
            cancelStyle: TextStyle(
              color: Theme.of(context).primaryColorDark,
            ),
            containerHeight: 210.0,
          ),
          showTitleActions: true,
          minTime: DateTime(2000, 1, 1),
          maxTime: DateTime(2030, 12, 31),
          onConfirm: (date) {
            print('confirm $date');
            setState(() {
              pickeddate = "${date.year}/${date.month}/${date.day}";
              prefs.setString('String', pickeddate);
            });
          },
          currentTime: DateTime.now(),
          locale: LocaleType.jp);
    });
    prefs.getString('String');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リペア・備品購入履歴　'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Card(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  //elevation: 4.0,
                  onTap: _incrementCounter,
                  title: Text('最後にリペアした日'),
                  trailing: Container(
                    child: (pickeddate == null)
                        ? Text(
                      'Not set',
                      style: TextStyle(
                          fontSize: 18.0
                      ),
                    )
                        : Text(
                      '$pickeddate',
                      style: TextStyle(
                          fontSize: 18.0
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}