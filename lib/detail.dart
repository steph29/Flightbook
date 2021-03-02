import 'package:flutter/material.dart';
import 'flight.dart';
import 'dataBaseClient.dart';
import 'ajout-vol.dart';
import 'PasDeVol.dart';
import 'main.dart';


class Detail extends StatefulWidget {
	Flight flight;

	Detail(Flight flight){
		this.flight = flight;
	}

	@override
	_DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail>{
	List<Flight> flights;

	@override
	void initState() {
    super.initState();
    DataBaseClient().allItem().then((liste) {
    	setState(() {
    	  flights = liste;
    	});
    });
  }

	@override
	Widget build(BuildContext context) {
    return new Scaffold(
	    body: (flights == null || flights.length == 0 ) ? PasDeVol() :

	   new Container(
		   decoration: BoxDecoration(
			   color: Color(0xFF191B2C)
		   ),
		   child: new Center(
			   child: new Container(
				   width: MediaQuery.of(context).size.width/1.5,
				   height: MediaQuery.of(context).size.height/2,
				   decoration: BoxDecoration(
					   color: Color(0xFF191B2C),
				   ),
				   child: new Card(
					   color: Color(0xFF424665),
					   elevation: 15.0,
					   child: new Column(
						   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						   children: <Widget>[
						   	Rang(widget.flight.cda, 'assets/piloteTete1.png', 25.0, FontWeight.bold),
							   textAvecStyle(widget.flight.date.toString()),
							   textAvecStyle(widget.flight.obs),
							   textAvecStyle('Avion : ${widget.flight.avion}'),
							   textAvecStyle('Heure de jour : ${widget.flight.heureJ.toString()}'),
							   textAvecStyle('Heure de nuit : ${widget.flight.heureN.toString()}'),
//							   textAvecStyle('Total : ${total(widget.flight.heureJ, widget.flight.heureN).toString()}'),

							   ],

					   ),
				   ),
			   ),
		   ),
	   ),

	    floatingActionButton: FloatingActionButton(
		    backgroundColor: Color(0xffE27460),
		    onPressed: () {
			    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext){
				    return new MyHomePage();
			    }));
		    },
		    child: Icon(Icons.navigate_before, color: Color(0xffF6F6F6),),
	    ),
		    );
  }

	Widget Rang(String text, String image, double fontSize, FontWeight fontWeight){
	return	Row(
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
				Image.asset(image),
				textAvecStyle(text, color: Color(0xffE27460), fontSize: fontSize, fontWeight: FontWeight.normal),
			],
		);
	}

Text textAvecStyle(String data, {color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal}){
		return Text(data,
			style: new TextStyle(
				color: color,
				fontStyle: fontStyle,
				fontWeight: fontWeight,
				fontSize: fontSize,
			),
		);
}
  double total(double heureJ, double heureN){
		return heureJ + heureN;
  }
}