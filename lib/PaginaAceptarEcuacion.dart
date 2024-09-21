// ignore: file_names
import 'package:factorizacion_por_division_sintetica/PaginaCrearEcuacion.dart';
import 'package:factorizacion_por_division_sintetica/PaginaResultado.dart';
import 'package:flutter/material.dart';
import 'package:factorizacion_por_division_sintetica/polinomio.dart';

class PaginaAceptarEcuacion extends StatelessWidget {
  final Polinomio polinomio;

  const PaginaAceptarEcuacion({super.key, required this.polinomio});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
              '¿El polinomio es correcto?',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            const SizedBox(height: 20),
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
                              PaginaCrearEcuacion(polinomio: polinomio),
                        ),
                      );
                    },
                    child: const Text('Volver',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.bold,
                            fontSize: 20))),
                const Image(
                  image: AssetImage('assets/shinji.png'),
                  width: 300,
                ),
                const SizedBox(height: 20),
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
                              PaginaResultado(polinomio: polinomio),
                        ),
                      );
                    },
                    child: const Text('Aceptar',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _mostrarEcuacion() {
    String ecuacion = '';
    for (int i = 0; i < polinomio.coeficientes.length; i++) {
      double coeficiente = polinomio.coeficientes[i];
      int exponente = polinomio.grado - i;

      if (coeficiente != 0) {
        if (i > 0 && coeficiente > 0) {
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
