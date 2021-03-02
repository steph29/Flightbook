import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'ajout-vol.dart';

class PasDeVol extends StatelessWidget{
	@override
	Widget build(BuildContext context) {
    return new Scaffold(
	    backgroundColor:  Color(0xff191B2C),
	    body: new Center(
		    child:(Platform.isIOS) ? new Text('Pas de vol d\'enregistré ', style: new TextStyle(color:  Color(0xffF6F6F6), fontSize: 18.0, fontWeight: FontWeight.bold),)
				    :  new Text('Pas de vol d\'enregistré ', style: new TextStyle(color: Color(0xff191B2C), fontStyle: FontStyle.normal, fontSize: 30.0),),
	    ),
    );
  }
}