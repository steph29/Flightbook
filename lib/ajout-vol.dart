import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'flight.dart';
import 'dataBaseClient.dart';
import 'datePicker.dart';
import 'main.dart';

class Ajout extends StatefulWidget{
	int id;
	Ajout(){
		this.id = id;
	}

	@override
	_AjoutState createState() => new _AjoutState();

}

class _AjoutState extends State<Ajout>{
	String cda;
	String obs;
	String avion;
	String date;
	var heureN;
	var heureJ;

	@override
	Widget build(BuildContext context) {
    return new Scaffold(
	    body: new SingleChildScrollView(
		    child: new Container(
			    width: MediaQuery.of(context).size.width,
			    height: MediaQuery.of(context).size.height,
			    decoration: BoxDecoration(
				    color: Color(0xFF191B2C)
			    ),
			    child:new Column(
					    children: <Widget>[
			    new Card(
			    margin: EdgeInsets.only(top: 100.0, right: 30.0, left: 30.0),
				    elevation: 8.0,
				    child: new Column(
					    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					    children: <Widget>[
						    textField(TypeTextField.cda, 'cda'),
						    textField(TypeTextField.obs, 'obs'),
						    textField(TypeTextField.avion, 'avion'),
						    textField(TypeTextField.date, 'date'),
						    textField(TypeTextField.heureJ, 'heureJ'),
						    textField(TypeTextField.heureN, 'heureN'),
					    ],
				    ),
		    ),
			    ],
		    ),
	    ),
	    ),
	    floatingActionButton: FloatingActionButton(
		    backgroundColor: Color(0xffE27460),
		    onPressed: () {
		    	ajouter();
			    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext){
				    return new MyHomePage();
			    }));
		    },
		    child: Icon(Icons.check, color: Color(0xffF6F6F6),),
	    ),
    );
  }



	TextField textField(TypeTextField type, String label)  {
		return new TextField(
		keyboardType: (type == TypeTextField.heureN || type == TypeTextField.heureJ || type == TypeTextField.avion) ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text ,
			decoration: new InputDecoration(
				labelText: label,

			),
			onChanged: (String string){
				switch (type){
					case TypeTextField.cda:
						cda = string;
						break;
					case TypeTextField.obs:
						obs = string;
						break;
					case TypeTextField.avion:
					    avion = string;
					    break;
					case TypeTextField.heureN:
						heureN = string;
						break;
					case TypeTextField.heureJ:
						heureJ = string;
						break;
					case TypeTextField.date:
						date = string ;
						break;
				};
			},
		);
	}

	void ajouter(){
		if(cda != null){
			Map<String, dynamic> map = {
				'cda': cda,
				'flight': widget.id,
			};
			if(obs != null){
				map['obs'] = obs;
			}
			if (date != null){
				map['date'] = date;
			}
			if(date != null){
			    map['avion'] = avion;
			}
			if (heureJ != null){
				map['heureJ'] = heureJ;
			}
			if (heureN != null){
				map['heureN'] = heureN;
			}
			Flight flight = new Flight();
			flight.fromMap(map);
			DataBaseClient().upsertFlight(flight).then((value) {
				cda = null;
				obs = null;
				date = null;
				avion = null;
				heureJ = null;
				heureN = null;
				Navigator.pop(context);
			});
		}
	}
}

enum TypeTextField {
	cda, obs, avion, heureJ, heureN, date
}

