import 'package:factorizacion_por_division_sintetica/PaginaDefinirGradoEcuacion.dart';
import 'package:flutter/material.dart';

class PaginaBienvenida extends StatelessWidget {
  const PaginaBienvenida({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/LSlogo.png'),
              width: 500,
            ),
            const SizedBox(height: 40),
            const Text(
              "Ingeniería en Software y Sistemas Computacionales",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Métodos Numéricos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Héctor Paulo ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Arial',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Diego Sosa Ramírez",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Arial',
              ),
            ),
            // const SizedBox(height: 20),
            // const Text(
            //   "Diego Sosa Ramírez",
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 20,
            //     fontFamily: 'Arial',
            //   ),
            // ),
            const SizedBox(height: 40),
            const Text(
              "Factorización por Método de División Sintética",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              "Septiembre 2024",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            // Agregando el TextButton correctamente con estilo y funcionalidad
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16.0),
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                // Navegación a la segunda página usando Navigator.push()
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaginaDefinirGradoEcuacion()),
                );
              },
              child: const Text('Ir al procedimiento'),
            ),
            const SizedBox(height: 60),
            const Text("Versión 1.0.0", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
