// ignore: file_names
import 'package:factorizacion_por_division_sintetica/PaginaCrearEcuacion.dart';
import 'package:flutter/material.dart';
import 'package:factorizacion_por_division_sintetica/polinomio.dart';

class PaginaAceptarEcuacion extends StatelessWidget {
  final Polinomio polinomio;

  const PaginaAceptarEcuacion({super.key, required this.polinomio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ecuación Original: ${_mostrarEcuacion()}',
              style: const TextStyle(fontSize: 25, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Resultado de la División Sintética: (papuraíz)',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaginaCrearEcuacion(polinomio: polinomio),
                        ),
                      );
                    },
                    child: const Text('Volver',
                        style: TextStyle(color: Colors.white))),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaginaCrearEcuacion(polinomio: polinomio),
                        ),
                      );
                    },
                    child: const Text('Aceptar',
                        style: TextStyle(color: Colors.white))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _mostrarEcuacion() {
    String ecuacion = '';
    for (int i = 1; i < polinomio.coeficientes.length; i++) {
      int coeficiente = polinomio.coeficientes[i];
      int exponente = polinomio.grado - i;

      if (coeficiente != 0) {
        if (i > 1 && coeficiente > 0) {
          ecuacion += ' + ';
        } else if (coeficiente < 0) {
          ecuacion += ' - ';
          coeficiente = coeficiente.abs();
        }

        if (exponente > 1) {
          ecuacion += '${coeficiente}x^$exponente';
        } else if (exponente == 1) {
          ecuacion += '${coeficiente}x';
        } else {
          ecuacion += '$coeficiente';
        }
      }
    }
    return ecuacion;
  }
}
