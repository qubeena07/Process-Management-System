//this file displays deadline of running processes in calendar
//importing packages

import 'package:flutter/material.dart';
import 'package:proces/controller/create_new_project_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

//creating a stateful Widget
class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

//creating private class that returns calender with deadline dates and names of running processess
class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //the bodyof this calender is Sf calendar provided by Syncfunction inc
      body: SfCalendar(
        //selecting calenar schedule view
        view: CalendarView.schedule,
        //retrieveing datasource for the calendar
        dataSource: MeetingDataSource(getAppointments()),
      ),
    );
  }
}

//Getting data for calendar
List<Appointment> getAppointments() {
  //creating a variable to save the details of deadline day
  List<Appointment> meetings = <Appointment>[];
  //calling controller to retrieve runing processes details
  final procescontroller = Get.put(CreateNewUser());
  var len = procescontroller.Process.length;
  //Going through all the running processes
  for (len; len > 1; len--) {
    //filtering deadline and process name for the calendar
    var date = procescontroller.Process[len - 1].Deadline;
    DateTime tempDate = DateTime.parse(date!);
    var topic = procescontroller.Process[len - 1].name;
    //adding deafline deataild in variable
    meetings.add(Appointment(
        startTime: tempDate,
        endTime: tempDate,
        subject: topic!,
        color: Colors.blue,
        isAllDay: true));
  }
  //returing the variable to the calendar with multiple process deatails
  return meetings;
}

//class for detarimining data source for calendar
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
