import 'package:flutter/material.dart';
import 'package:factorizacion_por_division_sintetica/polinomio.dart';

class PaginaResultado extends StatefulWidget {
  final Polinomio polinomio;

  const PaginaResultado({super.key, required this.polinomio});

  @override
  _PaginaResultadoState createState() => _PaginaResultadoState();
}

class _PaginaResultadoState extends State<PaginaResultado> {
  List<Widget> _mensajes = [];
  Set<double> _raices = {};

  @override
  void initState() {
    super.initState();
    _calcularDivisionSintetica();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 0, 157, 3),
        title: const Text(
          'S O L U C I O N E S',
          style: TextStyle(
              fontSize: 30, fontFamily: 'Arial', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                children: _mensajes,
              ),
              Column(
                children: _raices.map((raiz) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.beenhere, color: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        raiz.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'Monaspace Neon',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              Image.asset(
                'assets/monaChina.png',
                fit: BoxFit.cover,
                width: 600,
              ),
              Container(
                width: 200,
                height: 1,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calcularDivisionSintetica() {
    List<double> coeficientes = widget.polinomio.coeficientes;
    double valorIndependiente = widget.polinomio.coeficientes.last;
    List<double> divisores = [];

    for (int i = 1; i <= valorIndependiente.abs(); i++) {
      if (valorIndependiente % i == 0) {
        divisores.add(i.toDouble());
        divisores.add(-i.toDouble());
      }
    }

    for (var divisor in divisores) {
      List<double> resultados = [];
      List<double> fila2 = [];
      bool esRaiz =
          _procesarDivisionSintetica(coeficientes, divisor, resultados, fila2);

      setState(() {
        _mensajes.add(Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _crearMensaje("$divisor", ""),
                const Icon(Icons.navigate_next, color: Colors.amber),
                _crearMensaje("${coeficientes.toString()} ", ""),
              ],
            ),
            _crearMensaje("${fila2.toString()} ", ""),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _crearMensaje("${resultados.toString()} ", ""),
                Icon(esRaiz ? Icons.check : Icons.close,
                    color: esRaiz ? Colors.green : Colors.red),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ));
        if (esRaiz) {
          _raices.add(divisor);
        }
      });
    }

    for (double i = -10; i <= 10; i += 0.1) {
      i = double.parse(i.toStringAsFixed(1));
      List<double> resultados = [];
      List<double> fila2 = [];
      bool esRaiz =
          _procesarDivisionSintetica(coeficientes, i, resultados, fila2);

      setState(() {
        if (esRaiz) {
          _raices.add(i);
        }
      });
    }

    // Probar divisores fraccionarios
    for (double i = -10; i <= 10; i += 0.1) {
      for (double j = 1; j <= 10; j += 0.1) {
        double divisor = i / j;
        divisor = double.parse(divisor.toStringAsFixed(2));
        List<double> resultados = [];
        List<double> fila2 = [];
        bool esRaiz = _procesarDivisionSintetica(
            coeficientes, divisor, resultados, fila2);

        setState(() {
          if (esRaiz) {
            _raices.add(divisor);
          }
        });
      }
    }
  }

  bool _procesarDivisionSintetica(List<double> coeficientes, double divisor,
      List<double> resultados, List<double> fila2) {
    List<double> fila1 = [coeficientes[0]];
    for (int j = 1; j < coeficientes.length; j++) {
      double valorFila2 = fila1[j - 1] * divisor;
      fila2.add(valorFila2);
      double nuevoValor = coeficientes[j] + valorFila2;
      fila1.add(nuevoValor);
    }

    if (fila1.last.abs() < 1e-6) {
      resultados.addAll(fila1);
      return true;
    }
    resultados.addAll(fila1);
    return false;
  }

  Widget _crearMensaje(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            titulo,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Monaspace Neon',
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            valor,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Monaspace Neon'),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
