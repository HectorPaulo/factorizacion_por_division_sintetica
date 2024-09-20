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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Soluciones',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              _divisionSintetica(),
              style: const TextStyle(fontSize: 18, color: Colors.white),
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
                            PaginaAceptarEcuacion(polinomio: polinomio),
                      ),
                    );
                  },
                  child: const Text('Volver',
                      style: TextStyle(color: Colors.white)),
                ),
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
                      style: TextStyle(color: Colors.white)),
                ),
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

  String _divisionSintetica() {
    String ecuacion = _mostrarEcuacion();
    bool esRaiz = false;
    double divisorRaiz = 0; // Variable para almacenar el divisor raíz
    List<double> divisores = [];
    List<double> resultado = [];
    double terminoIndependiente = polinomio.coeficientes.last;
    double coeficienteLider = polinomio.coeficientes.first;

    // Calcular los divisores del término independiente y del coeficiente líder
    for (double i = 1; i <= terminoIndependiente.abs(); i++) {
      if (terminoIndependiente % i == 0) {
        divisores.add(i / coeficienteLider);
        divisores.add(-i / coeficienteLider);
      }
    }

    // Probar cada divisor con división sintética
    for (double divisor in divisores) {
      resultado.clear();
      resultado.add(polinomio.coeficientes[0]);

      for (int j = 1; j < polinomio.coeficientes.length; j++) {
        double aux = polinomio.coeficientes[j] + resultado[j - 1] * divisor;
        resultado.add(aux);
      }

      // Si el último elemento de 'resultado' es 0, divisor es una raíz
      if (resultado.last == 0) {
        esRaiz = true;
        divisorRaiz = divisor; // Guardar el divisor raíz
        break;
      }
    }

    if (esRaiz) {
      return "Raíz encontrada: $divisorRaiz \nResultados: ${resultado.toString()}";
    } else {
      return "No se encontró una raíz exacta.";
    }
  }
}
