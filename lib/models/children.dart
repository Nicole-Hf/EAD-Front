class Children{
  int? id;
  String? nombre;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? edad;
  String? sexo;
  String? fechaNacimiento;
  String? image;
  String? nombreMadre;
  String? nombrePadre;
  String? telefonoEmergencia;
  String? sala;

  Children({
    this.id,
    this.nombre,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.edad,
    this.sexo,
    this.fechaNacimiento,
    this.image,
    this.nombreMadre,
    this.nombrePadre,
    this.telefonoEmergencia,
    this.sala,
  });

  factory Children.fromJson(Map<String, dynamic> json) {
    return Children(
      id: json['children']['id'],
      nombre: json['children']['nombre'],
      apellidoPaterno: json['children']['apellidoPaterno'],
      apellidoMaterno: json['children']['apellidoMaterno'],
      edad: json['children']['edad'],
      sexo: json['children']['sexo'],
      fechaNacimiento: json['children']['fechaNacimiento'],
      image: json['children']['image'],
      nombreMadre: json['children']['nombreMadre'],
      nombrePadre: json['children']['nombrePadre'],
      telefonoEmergencia: json['children']['telefonoEmergencia'],
      sala: json['children']['sala'],
    );
  }

}