import 'package:FastCHECK/data/evento_data.dart'; 
import 'package:FastCHECK/screens/detalle_evento_screen.dart'; 
import 'package:FastCHECK/widgets/evento_card.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const EventosScreen(), 
    const Center(child: Text('Eventos', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Certificados', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Perfil', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: const Color.fromARGB(28, 81, 91, 255),
        buttonBackgroundColor: Colors.white,
        height: 50,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home, size: 25, color: Colors.black),
          Icon(Icons.event, size: 25, color: Colors.black),
          Icon(Icons.school, size: 25, color: Colors.black),
          Icon(Icons.person, size: 25, color: Colors.black),
        ],
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class EventosScreen extends StatelessWidget {
  const EventosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: eventos.length,
      itemBuilder: (context, index) {
        final evento = eventos[index];
        return EventoCard(
          evento: evento,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetallesEventoScreen(evento: evento),
              ),
            );
          },
        );
      },
    );
  }
}