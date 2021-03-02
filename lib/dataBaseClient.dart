import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'flight.dart';

class DataBaseClient {
	Database _database;

	Future<Database> get dataBase async {
		if (_database != null) {
			return _database;
		} else {
			// Créér cette database
			_database = await create();
			return _database;
		}
	}

	Future create() async {
		Directory directory = await getApplicationDocumentsDirectory();
		String dataBase_directory = join(directory.path, 'database.db');
		var bdd = await openDatabase(dataBase_directory, version: 1, onCreate: _onCreate);
		return bdd;
	}

	Future _onCreate(Database db, int version) async {
		await db.execute('''
CREATE TABLE flight (
id INTEGER PRIMARY KEY, 
cda TEXT NOT NULL,
obs TEXT NOT NULL,
avion TEXT NOT NULL,
date TEXT NOT NULL,
heureJ TEXT NOT NULL,
heureN TEXT NOT NULL
)
''');
	}

	/* ECRITURE DES DONNÉES */

	Future<Flight> ajouterItem(Flight flight) async {
		Database maDatabase = await dataBase;
		flight.id = await maDatabase.insert('flight', flight.toMap());
		return flight;
	}

	Future<int> updateFlight(Flight flight) async{
		Database maDataBase = await dataBase;
		return maDataBase.update('flight', flight.toMap(), where: 'id= ? ', whereArgs: [flight.id]);
	}

	Future<Flight> upsertFlight(Flight flight) async{
		Database maDataBase = await dataBase;
		if(flight.id == null){
			flight.id = await maDataBase.insert('flight', flight.toMap());
		}else{
			await maDataBase.update('flight', flight.toMap(), where: 'id =?', whereArgs: [flight.id]);
		}
		return flight;
	}

	Future<int> delete(int id, String table) async {
		Database maDataBase = await dataBase;
		await maDataBase.delete('flight', where: 'id = ?' , whereArgs: [id]);
		return await maDataBase.delete(table, where: 'id = ?', whereArgs: [id]);

	}

/* LECTURE DES DONNÉES */

	Future<List<Flight>> allItem() async {
		Database maDataBase = await dataBase;
		List<Map<String, dynamic>> resultat = await maDataBase.rawQuery('SELECT * FROM flight');
		List<Flight> flights = [];
		resultat.forEach((map) {
			Flight flight = new Flight() ;
			flight.fromMap(map);
			flights.add(flight);
		});
		return flights;
	}

	Future<List<Flight>> allArticles(int flight)async {
		Database maDataBase = await dataBase;
		List<Map<String, dynamic>> resultat = await maDataBase.query('flight', where: 'flight = ?',whereArgs: [flight]);
		List<Flight> flights = [];
		resultat.forEach((map){
			Flight flight = new Flight();
			flight.fromMap(map);
			flights.add(flight);
		});
		return flights;
	}
}