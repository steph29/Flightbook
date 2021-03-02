import 'dart:io';
import 'package:flight_book/detail.dart';
import 'package:flutter/material.dart';
import 'flight.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'dataBaseClient.dart';
import 'PasDeVol.dart';
import 'ajout-vol.dart';
import 'detail.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Book',
      theme: ThemeData(
        backgroundColor: Color(0xFF191B2C),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flight Book'),
      debugShowCheckedModeBanner: false,

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.flight}) : super(key: key);
  final String title;
  Flight flight;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  DateTime date = DateTime.now();
  Flight flight;
  List<Flight> myFlight;
  String cda;
  String date;
  String avion;
  String obs;
  String heureJ;
  String heureN;

  @override
void initState() {
    super.initState();
   recuperer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: (Platform.isIOS) ?
          new Container(
            decoration: BoxDecoration(
              color:  Color(0xff191B2C)
            ),
            child:  new SafeArea(child: new Scaffold(
                body:  (myFlight == null || myFlight.length == 0) ? new PasDeVol() : new Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: bodyIos(),
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Color(0xffE27460),
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext){
                      recuperer();
                      return new Ajout();
                    }));
                  },
                  child: Icon(Icons.add, color: Color(0xffF6F6F6),),
                )
            ),

            ) ,
          )
    :
       new Scaffold(
        body: (myFlight == null || myFlight.length == 0) ? new PasDeVol() : new Container(
          decoration: BoxDecoration(
            color: Color(0xff191B2C),
          ),
          child: body(),

        ),
         floatingActionButton: FloatingActionButton(
           backgroundColor: Color(0xffE27460),
           onPressed: () {
             Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext){
               recuperer();
               return new Ajout();
             }));
           },
           child: Icon(Icons.add, color: Color(0xffF6F6F6),),
         ),

      )
    );
  }

  Widget body(){
    return new ListView.builder(
            itemCount: myFlight.length,
            itemBuilder: (context, i ) {
              Flight flight = myFlight[i];
              return Container(
                decoration: BoxDecoration(
                    color: Color(0xFF424665),
                    border: Border.all(color: Color(0xFF424665), width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(50.0))
                ),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                child:   new ListTile(
                  leading: Icon(Icons.flight_takeoff, color: Colors.grey[100]),
                  title: Text(flight.cda),
                  subtitle: Text(flight.obs),
                  onTap: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext) {
                      return new Detail(flight);
                    }));
                  },
                  trailing: new IconButton(
                      icon: Icon(Icons.delete, color: Colors.grey[100],),
                      onPressed: (){
                        print('delete');
                        DataBaseClient().delete(flight.id, 'flight').then((int) {
                          recuperer();
                        });
                      },
                  ),
                ),
              );
            }
        );
  }

  LinearGradient colorDeFont(){
    return new LinearGradient(
        colors: [Color(0xFF252350), Color(0xFF5C3F92)],
        begin: const FractionalOffset(0.0, 1.0),
        end: const FractionalOffset(0.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp
    );
}

Widget bodyTestIos(){
    return new Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color(0xFF5C3F92)
      ),
    );
}

Widget bodyIos(){
  return SafeArea(
    child: new ListView.builder(
        itemCount: myFlight.length,
        itemBuilder: (context, i ) {
          Flight flight = myFlight[i];
          return Container(
            decoration: BoxDecoration(
                color: Color(0xFF424665),
                border: Border.all(color: Color(0xFF424665), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(50.0))
            ),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            child:new ListTile(
              leading: Icon(Icons.flight_takeoff, color: Colors.grey[100]),
              title: Text(flight.cda),
              subtitle: Text(flight.obs),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildContext) {
                  return new Detail(flight);
                }));
              },
              trailing: new IconButton(
                  icon: Icon(Icons.delete, color: Colors.grey[100],),
                  onPressed: (){
                    print('delete');
                    DataBaseClient().delete(flight.id, 'flight').then((int) {
                      recuperer();
                    });
                  }),
            ) ,
          );
        }
    ),
  );
}





  Text textAvecStyle(String data, {color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic, textAlign: TextAlign.center, fontWeight: FontWeight.normal}) {
    return new Text(
      data,
      style: new TextStyle(
        color: color,
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }

void recuperer(){
  DataBaseClient().allItem().then((myFlight) {
    setState(() {
      this.myFlight = myFlight;
    });
  });
}
}
