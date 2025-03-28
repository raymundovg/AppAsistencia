import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/evento_model.dart';

class DetallesEventoScreen extends StatelessWidget {
  final Evento evento;

  const DetallesEventoScreen({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(evento.nombre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              evento.imagen, 
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              evento.nombre,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              evento.descripcion,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 5),
                Text(
                  evento.ubicacion,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // Abrir el enlace de la ubicación
                launchUrl(Uri.parse(evento.linkUbicacion));
              },
              child: Text(
                'Ver ubicación',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue[600],
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Horario: ${evento.horario}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}