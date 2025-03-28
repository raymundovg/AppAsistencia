
import '../models/evento_model.dart';

final List<Evento> eventos = [
  Evento(
    id: '1',
    nombre: 'Conferencia de Tecnología',
    descripcion: 'Una conferencia sobre las últimas tendencias en tecnología.',
    ubicacion: 'Auditorio Palavicini',
    imagen: 'assets/palavicini.png',
    linkUbicacion: 'https://maps.app.goo.gl/VSYncKNhWyMNBHYy8',
    horario: '10:00 AM - 11:00 AM', 
  ),
  Evento(
    id: '2',
    nombre: 'Taller de Flutter',
    descripcion: 'Aprende a desarrollar aplicaciones móviles con Flutter.',
    ubicacion: 'UJAT, DACYTI Edificio x, sala X2',
    imagen: 'assets/dacyti.png', 
    linkUbicacion: 'https://maps.app.goo.gl/hAG2hBSuSgNqZJmc6',
    horario: '9:00 AM - 1:00 PM',
  ),
];