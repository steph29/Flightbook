class Flight {
	int id;
	String cda;
	String date;
	String avion;
	String obs;
	var heureJ;
	var heureN;

	Flight();

void fromMap(Map<String, dynamic> map){
	this.id = map['id'];
	this.cda = map['cda'];
	this.obs = map['obs'];
	this.avion = map['avion'];
	this.date = map['date'];
	this.heureJ = map['heureJ'];
	this.heureN = map['heureN'];
  }

	Map<String, dynamic> toMap(){
		Map<String, dynamic> map = {
			'cda': this.cda,
			'obs': this.obs,
			'avion': this.avion,
			'date': this.date,
			'heureJ': this.heureJ,
			'heureN': this.heureN,
		};
		if(id != null){
			map['id'] = this.id;
		}
		return map;
	}
}

