import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class DatePicker extends StatefulWidget{

	@override
	DatePickerState createState() => new DatePickerState();

}

class DatePickerState extends State<DatePicker>{
	DateTime dateTime = DateTime.now();
	@override
	Widget build(BuildContext context) {
		 (Platform.isIOS) ?  dateTimeIos() :  dateTimeAndroid() ;
	}
Future<Null> dateTimeIos() async {
		CupertinoDatePicker(
			initialDateTime: dateTime,
			mode: CupertinoDatePickerMode.date,
			onDateTimeChanged: (dateTimes) {
				setState(() {
				  dateTime = dateTimes;
				});
			},
		);
}

	Future<Null> dateTimeAndroid()  async {
		DateTime monAge = await showDatePicker(
				context: context,
				initialDatePickerMode: DatePickerMode.year,
				initialDate: new DateTime.now(),
				firstDate: new DateTime(1900),
				lastDate: new DateTime(2099));
				setState(() {
					dateTime = monAge;
				});
	}
}