import 'package:factorizacion_por_division_sintetica/PaginaAceptarEcuacion.dart';
import 'package:factorizacion_por_division_sintetica/PaginaBienvenida.dart';
import 'package:factorizacion_por_division_sintetica/polinomio.dart';
import 'package:flutter/material.dart';

class PaginaResultado extends StatelessWidget {
  final Polinomio polinomio;

  const PaginaResultado({super.key, required this.polinomio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        title: const Text('S O L U C I O N E S',
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaginaBienvenida()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(height: 20),
                Image(image: AssetImage('assets/PedritoSola.gif'), width: 200),
                SizedBox(width: 50),
                Text(
                  _divisionSintetica(),
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 20),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Color.fromRGBO(225, 28, 28, 0.98),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PaginaAceptarEcuacion(polinomio: polinomio),
                      ),
                    );
                  },
                  child: const Text('Volver',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PaginaAceptarEcuacion(polinomio: polinomio),
                      ),
                    );
                  },
                  child: const Text('Aceptar',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _divisionSintetica() {
    double coeficienteLider = polinomio.coeficientes.first;
    double terminoIndependiente = polinomio.coeficientes.last;
    List<double> divisores = []; // Lista de divisores posibles
    List<double> raices = []; // Lista de raíces que funcionan
    List<Map<String, dynamic>> iteraciones =
        []; // Para registrar las iteraciones
    int n = polinomio.coeficientes.length - 1; // Grado del polinomio

    // Encontrar los posibles divisores del término independiente
    for (int i = 1; i <= terminoIndependiente.abs(); i++) {
      if (terminoIndependiente % i == 0) {
        divisores.add(i / coeficienteLider); // Divisor positivo
        divisores.add(-i / coeficienteLider); // Divisor negativo
      }
    }

    // Probar cada divisor con la división sintética
    for (double divisor in divisores) {
      List<double> resultado = [
        polinomio.coeficientes[0]
      ]; // Iniciar con el coeficiente líder
      List<double> pasosIteracion = [
        polinomio.coeficientes[0]
      ]; // Guardar el primer paso

      // Realizar la división sintética
      for (int j = 1; j <= n; j++) {
        double aux = polinomio.coeficientes[j] + (resultado[j - 1] * divisor);
        resultado.add(aux);
        pasosIteracion.add(aux); // Guardar el paso en cada iteración
      }

      // Registrar la iteración actual
      iteraciones.add({
        'divisor': divisor,
        'resultados': List.from(pasosIteracion), // Copia de los pasos
      });

      // Verificar si el último valor es cero, lo que indica que es una raíz
      if (resultado.last == 0) {
        raices.add(divisor); // Guardar la raíz
      }
    }

    // Formatear la salida para incluir toda la información
    StringBuffer salida = StringBuffer();
    salida.writeln("Divisores probados: $divisores");

    if (raices.isNotEmpty) {
      salida.writeln("Raíces encontradas: $raices");
    } else {
      salida.writeln("No se encontró una raíz exacta.");
    }

    // Mostrar las iteraciones de la división sintética
    salida.writeln("Iteraciones de cada división sintética:");
    for (var iteracion in iteraciones) {
      salida.writeln(
          "Divisor: ${iteracion['divisor']}, Resultados: ${iteracion['resultados']}");
    }

    return salida.toString();
  }
}
