import 'package:factorizacion_por_division_sintetica/PaginaAceptarEcuacion.dart';
import 'package:factorizacion_por_division_sintetica/polinomio.dart';
import 'package:flutter/material.dart';

class PaginaResultado extends StatelessWidget {
  final Polinomio polinomio;

  const PaginaResultado({super.key, required this.polinomio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
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
      int coeficiente = polinomio.coeficientes[i];
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
// TODO --> Implementar la division sintetica
  // double _divisionSintetica(){
  //   String ecuacion = _mostrarEcuacion();
}
