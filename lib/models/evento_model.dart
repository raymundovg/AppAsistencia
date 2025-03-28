// lib/models/evento_model.dart
class Evento {
  final String id;
  final String nombre;
  final String descripcion;
  final String ubicacion;
  final String imagen; 
  final String linkUbicacion;
  final String horario;

  Evento({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.ubicacion,
    required this.imagen,
    required this.linkUbicacion,
    required this.horario,
  });
}