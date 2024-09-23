import 'package:flutter/material.dart';
import 'package:factorizacion_por_division_sintetica/polinomio.dart';

class PaginaResultado extends StatefulWidget {
  final Polinomio polinomio;

  const PaginaResultado({super.key, required this.polinomio});

  @override
  _PaginaResultadoState createState() => _PaginaResultadoState();
}

class _PaginaResultadoState extends State<PaginaResultado> {
  String resultadoDivision = ''; // Variable para almacenar el resultado final

  @override
  void initState() {
    super.initState();
    _calcularDivisionSintetica(); // Calcular la división sintética al cargar la página
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 92, 13, 8),
        title: const Text(
          'S O L U C I O N E S',
          style: TextStyle(
              fontSize: 30, fontFamily: 'Arial', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              _mostrarEcuacion(),
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            // Mostrar el resultado de la división sintética
            Text(
              resultadoDivision,
              style: const TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:
                  const Text('Volver', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  String _mostrarEcuacion() {
    String ecuacion = '';
    for (int i = 0; i < widget.polinomio.coeficientes.length; i++) {
      double coeficiente = widget.polinomio.coeficientes[i];
      int exponente = widget.polinomio.grado - i;

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

  void _calcularDivisionSintetica() {
    List<double> coeficientes = widget.polinomio.coeficientes;
    double valorIndependiente = widget.polinomio.coeficientes.last;
    List<int> divisoresPositivos = [];
    List<int> divisoresNegativos = [];
    List<double> resultados = [];
    List<int> raices = [];

    print("Coeficientes: $coeficientes");
    print("Valor independiente: ${valorIndependiente}");

    // Verificar divisores positivos de valorIndependiente
    for (int i = 1; i <= valorIndependiente.abs(); i++) {
      if (valorIndependiente % i == 0) {
        divisoresPositivos.add(i);
      }
    }

    // Verificar divisores negativos de valorIndependiente
    for (int i = 1; i <= valorIndependiente.abs(); i++) {
      if (valorIndependiente % i == 0) {
        divisoresNegativos.add(-i);
      }
    }

    // Simular la división sintética para divisores positivos
    for (var divisor in divisoresPositivos) {
      _procesarDivisionSintetica(coeficientes, divisor, resultados, raices);
    }

    // Simular la división sintética para divisores negativos
    for (var divisor in divisoresNegativos) {
      _procesarDivisionSintetica(coeficientes, divisor, resultados, raices);
    }

    // Mostrar los resultados en la interfaz
    setState(() {
      resultadoDivision = "Valor independiente: ${valorIndependiente}\n\n"
          "Coeficientes: ${coeficientes}\n\n"
          "Raíces: $raices\n\n"
          "Resultados: $resultados";
    });
  }

  void _procesarDivisionSintetica(List<double> coeficientes, int divisor,
      List<double> resultados, List<int> raices) {
    print("Probando el divisor: $divisor");

    List<double> fila1 = [
      coeficientes[0]
    ]; // Inicializa la primera fila con el primer coeficiente
    for (int j = 1; j < coeficientes.length; j++) {
      double valorFila2 =
          fila1[j - 1] * divisor; // Multiplica el valor anterior por el divisor
      double nuevoValor = coeficientes[j] +
          valorFila2; // Suma el resultado a la siguiente posición
      fila1.add(nuevoValor); // Agrega el valor a la fila
      print(
          "Fila1 después del coeficiente $j: $fila1"); // Imprime la fila en cada iteración
    }

    // Si el último valor de la fila es 0, hemos encontrado una raíz
    if (fila1.last == 0) {
      raices.add(divisor);
      resultados.clear();
      resultados.addAll(fila1); // Guarda los resultados de la división
      print("Raíz encontrada: $divisor");
    } else {
      print("No es raíz: $divisor");
    }
  }
}
