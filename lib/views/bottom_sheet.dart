import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todolist/controller/task_controller.dart';
import 'package:todolist/views/home.dart';
import 'package:intl/intl.dart';
import '../utilities/util.dart';

class Modal {
  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return InputTaskWidget(context: context);
      },
    );
  }
}

class InputTaskWidget extends StatefulWidget {
  final context;
  InputTaskWidget({this.context});
  _InputTaskState createState() => _InputTaskState(context: this.context);
}

class _InputTaskState extends StateMVC<InputTaskWidget> {
  _InputTaskState({this.context}) : super(TaskController()) {
    cTask = controller;
  }
  TaskController cTask;
  BuildContext context;
  final txttaskname = TextEditingController();
  final formkey = GlobalKey<FormState>();
  var date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var time =
      DateFormat('HH:00:00').format(DateTime.now().add(Duration(hours: 1)));
  var datetime, datetimetext;
  var category = '';
  var reminder = 0;
  var reminderval = false;
  List<bool> tvisibility = [true, true, true, true, true, true];
  @override
  void initState() {
    super.initState();
    datetime = DateTime.parse(date + ' ' + time);
    setdatetimetext();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 80,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height / 25,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(175, 30),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 340,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/images/fab-delete.png'),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            CustomColors.PurpleLight,
                            CustomColors.PurpleDark,
                          ],
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.PurpleShadow,
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Form(
                    key: formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(
                          'Add new task',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: TextFormField(
                            controller: txttaskname,
                            validator: (value) {
                              if (value.trim() == '') {
                                return 'Task Name Must Be Filled';
                              }
                              return null;
                            },
                            autofocus: true,
                            style: TextStyle(
                                fontSize: 22, fontStyle: FontStyle.normal),
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 60,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1.0,
                                color: CustomColors.GreyBorder,
                              ),
                              bottom: BorderSide(
                                width: 1.0,
                                color: CustomColors.GreyBorder,
                              ),
                            ),
                          ),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: <Widget>[
                              Visibility(
                                visible: tvisibility[0],
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        tvisibility[0] = false;
                                        for (int i = 1; i < 6; i++) {
                                          tvisibility[i] = true;
                                        }
                                        category = 'Personal';
                                      });
                                    },
                                    child: Center(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 10.0,
                                            width: 10.0,
                                            margin: EdgeInsets.only(right: 4),
                                            decoration: BoxDecoration(
                                              color: CustomColors.YellowAccent,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('Personal'),
                                          ),
                                        ],
                                      ),
                                    )),
                                replacement: InkWell(
                                  onTap: () {
                                    setState(() {
                                      tvisibility[0] = true;
                                      category = '';
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text(
                                        'Personal',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        color: CustomColors.YellowAccent,
                                        boxShadow: [
                                          BoxShadow(
                                            color: CustomColors.GreenShadow,
                                            blurRadius: 5.0,
                                            spreadRadius: 3.0,
                                            offset: Offset(0.0, 0.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: tvisibility[1],
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        for (int i = 0; i < 6; i++) {
                                          tvisibility[i] = true;
                                        }
                                        tvisibility[1] = false;
                                        category = 'Work';
                                      });
                                    },
                                    child: Center(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 10.0,
                                            width: 10.0,
                                            margin: EdgeInsets.only(right: 4),
                                            decoration: BoxDecoration(
                                              color: CustomColors.GreenIcon,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('Work'),
                                          ),
                                        ],
                                      ),
                                    )),
                                replacement: InkWell(
                                  onTap: () {
                                    setState(() {
                                      tvisibility[1] = true;
                                      category = '';
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text(
                                        'Work',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        color: CustomColors.GreenIcon,
                                        boxShadow: [
                                          BoxShadow(
                                            color: CustomColors.GreenShadow,
                                            blurRadius: 5.0,
                                            spreadRadius: 3.0,
                                            offset: Offset(0.0, 0.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: tvisibility[2],
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        tvisibility[0] = true;
                                        tvisibility[1] = true;
                                        tvisibility[2] = false;
                                        tvisibility[3] = true;
                                        tvisibility[4] = true;
                                        tvisibility[5] = true;
                                        category = 'Meeting';
                                      });
                                    },
                                    child: Center(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 10.0,
                                            width: 10.0,
                                            margin: EdgeInsets.only(right: 4),
                                            decoration: BoxDecoration(
                                              color: CustomColors.PurpleIcon,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('Meeting'),
                                          ),
                                        ],
                                      ),
                                    )),
                                replacement: InkWell(
                                  onTap: () {
                                    setState(() {
                                      tvisibility[2] = true;
                                      category = '';
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text(
                                        'Meeting',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        color: CustomColors.PurpleIcon,
                                        boxShadow: [
                                          BoxShadow(
                                            color: CustomColors.PurpleShadow,
                                            blurRadius: 5.0,
                                            spreadRadius: 3.0,
                                            offset: Offset(0.0, 0.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: tvisibility[3],
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        tvisibility[0] = true;
                                        tvisibility[1] = true;
                                        tvisibility[2] = true;
                                        tvisibility[3] = false;
                                        tvisibility[4] = true;
                                        tvisibility[5] = true;
                                        category = 'Study';
                                      });
                                    },
                                    child: Center(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 10.0,
                                            width: 10.0,
                                            margin: EdgeInsets.only(right: 4),
                                            decoration: BoxDecoration(
                                              color: CustomColors.BlueIcon,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('Study'),
                                          ),
                                        ],
                                      ),
                                    )),
                                replacement: InkWell(
                                  onTap: () {
                                    setState(() {
                                      tvisibility[3] = true;
                                      category = '';
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text(
                                        'Study',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        color: CustomColors.BlueIcon,
                                        boxShadow: [
                                          BoxShadow(
                                            color: CustomColors.BlueShadow,
                                            blurRadius: 5.0,
                                            spreadRadius: 3.0,
                                            offset: Offset(0.0, 0.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: tvisibility[4],
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        tvisibility[0] = true;
                                        tvisibility[1] = true;
                                        tvisibility[2] = true;
                                        tvisibility[3] = true;
                                        tvisibility[4] = false;
                                        tvisibility[5] = true;
                                        category = 'Shopping';
                                      });
                                    },
                                    child: Center(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 10.0,
                                            width: 10.0,
                                            margin: EdgeInsets.only(right: 4),
                                            decoration: BoxDecoration(
                                              color: CustomColors.OrangeIcon,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('Shopping'),
                                          ),
                                        ],
                                      ),
                                    )),
                                replacement: InkWell(
                                  onTap: () {
                                    setState(() {
                                      tvisibility[4] = true;
                                      category = '';
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text(
                                        'Shopping',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        color: CustomColors.OrangeIcon,
                                        boxShadow: [
                                          BoxShadow(
                                            color: CustomColors.YellowShadow,
                                            blurRadius: 5.0,
                                            spreadRadius: 3.0,
                                            offset: Offset(0.0, 0.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: tvisibility[5],
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        tvisibility[0] = true;
                                        tvisibility[1] = true;
                                        tvisibility[2] = true;
                                        tvisibility[3] = true;
                                        tvisibility[4] = true;
                                        tvisibility[5] = false;
                                        category = 'Party';
                                      });
                                    },
                                    child: Center(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 10.0,
                                            width: 10.0,
                                            margin: EdgeInsets.only(right: 4),
                                            decoration: BoxDecoration(
                                              color:
                                                  CustomColors.DeeppurlpleIcon,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text('Party'),
                                          ),
                                        ],
                                      ),
                                    )),
                                replacement: InkWell(
                                  onTap: () {
                                    setState(() {
                                      tvisibility[5] = true;
                                      category = '';
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text(
                                        'Party',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        color: CustomColors.DeeppurlpleIcon,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                CustomColors.PurpleBackground,
                                            blurRadius: 5.0,
                                            spreadRadius: 3.0,
                                            offset: Offset(0.0, 0.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030),
                                    locale: Locale('id'))
                                .then((datepicked) {
                              if (datepicked != null) {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((timepicked) {
                                  if (timepicked != null) {
                                    date = DateFormat('yyyy-MM-dd')
                                        .format(datepicked);
                                    var now = new DateTime.now();
                                    time = DateFormat('HH:mm:ss').format(
                                        DateTime(
                                            now.year,
                                            now.month,
                                            now.day,
                                            timepicked.hour,
                                            timepicked.minute));
                                    datetime =
                                        DateTime.parse(date + ' ' + time);
                                    setdatetimetext();
                                  }
                                });
                              }
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Text(
                                  'Choose date',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      datetimetext,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: 5),
                                    RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(Icons.chevron_right),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Checkbox(
                                value: reminderval,
                                onChanged: (bool value) {
                                  setState(() {
                                    reminderval = value;
                                    if (value) {
                                      reminder = 1;
                                    } else {
                                      reminder = 0;
                                    }
                                  });
                                },
                              ),
                              Text('Reminder'),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        RaisedButton(
                          onPressed: () {
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => Home()),
                            // );
                            if (formkey.currentState.validate()) {
                              if (category == '') {
                                Fluttertoast.showToast(
                                    msg: "Choose Category First");
                              } else {
                                if (datetime == '') {
                                  Fluttertoast.showToast(
                                      msg: "Choose Date Time First");
                                } else {
                                  var result = cTask.setTask(
                                      taskname: txttaskname.text.trim(),
                                      category: category,
                                      reminder: reminder,
                                      reminder_at: datetime,
                                      created_at:
                                          DateFormat('yyyy-MM-dd HH:mm:ss')
                                              .format(DateTime.now()));
                                  if (result) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Task Has Been Saved Successfully");
                                    Navigator.pop(context);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Failed To Add Task");
                                  }
                                }
                              }
                            }
                            // Navigator.pop(context);
                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 60,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  CustomColors.BlueLight,
                                  CustomColors.BlueDark,
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: CustomColors.BlueShadow,
                                  blurRadius: 2.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(0.0, 0.0),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Center(
                              child: const Text(
                                'Add task',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setdatetimetext() {
    setState(() {
      if (date == DateFormat('yyyy-MM-dd').format(DateTime.now())) {
        datetimetext = 'Today, ' +
            DateFormat('hh.mm a').format(DateTime.parse(date + ' ' + time));
      } else {
        datetimetext = DateFormat('dd MMM yyyy').format(DateTime.parse(date)) +
            ', ' +
            DateFormat('hh.mm a').format(DateTime.parse(date + ' ' + time));
      }
    });
  }
}
