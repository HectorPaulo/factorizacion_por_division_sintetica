import 'package:factorizacion_por_division_sintetica/PaginaAceptarEcuacion.dart';
import 'package:factorizacion_por_division_sintetica/polinomio.dart';
import 'package:flutter/material.dart';

class PaginaResultado extends StatelessWidget {
  final Polinomio polinomio;

  const PaginaResultado({super.key, required this.polinomio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Soluciones',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                const SizedBox(width: 20),
                // TODO: --> Mostrar las soluciones
                Text(
                  _divisionSintetica(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
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
                            style: TextStyle(color: Colors.white))),
                    const SizedBox(width: 20),
                    TextButton(
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
                            style: TextStyle(color: Colors.white))),
                  ],
                )
              ],
            )
          ],
        )));
  }

  String _mostrarEcuacion() {
    String ecuacion = '';
    for (int i = 0; i < polinomio.coeficientes.length; i++) {
      double coeficiente = polinomio.coeficientes[i];
      double exponente = polinomio.grado - i;

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

// TODO --> Implementar la division sintetica
  String _divisionSintetica() {
    String ecuacion = _mostrarEcuacion();
    bool esRaiz = false;
    var divisores = [];
    var resultado = [];
    // int divisor;
    double terminoIndependiente =
        polinomio.coeficientes[(polinomio.grado) as int];
    do {
      // --> calcular los divisores
      for (double i = 0; i < terminoIndependiente; i++) {
        if (terminoIndependiente % i == 0) {
          divisores.add(i);
          divisores.add(-i);
        }
      }
      for (double i = 0; i < divisores.length; i++) {
        resultado.add(polinomio.coeficientes[0]);
        for (int j = 1; j < polinomio.grado; i++) {
          double aux = polinomio.coeficientes[j] + resultado[j - 1] * i;
          resultado.add(aux);
        }
        // divisor = i;
        if (resultado[0] == 0) {
          // print("El divisor ", divisor, " es raíz.");
          esRaiz = true;
        }
      }
    } while (polinomio.grado >= 2 && esRaiz == false);
    if (polinomio.grado == 1) {}
    return ecuacion;
  }
}
