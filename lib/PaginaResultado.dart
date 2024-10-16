import 'package:flutter/material.dart';
import 'package:factorizacion_por_division_sintetica/polinomio.dart';

class PaginaResultado extends StatefulWidget {
  final Polinomio polinomio;

  const PaginaResultado({super.key, required this.polinomio});

  @override
  _PaginaResultadoState createState() => _PaginaResultadoState();
}

class _PaginaResultadoState extends State<PaginaResultado> {
  String resultadoDivision = '';
  List<Widget> _mensajes = [];

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
        backgroundColor: const Color.fromARGB(255, 74, 7, 7),
        title: const Text(
          'S O L U C I O N E S',
          style: TextStyle(
              fontSize: 30, fontFamily: 'Arial', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 6, 29, 46),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: _mensajes,
          ),
        ),
      ),
    );
  }

  void _calcularDivisionSintetica() {
    List<double> coeficientes = widget.polinomio.coeficientes;
    double valorIndependiente = widget.polinomio.coeficientes.last;
    List<int> divisoresPositivos = [];
    List<int> divisoresNegativos = [];
    List<double> resultados = [];
    List<int> raices = [];

    setState(() {
      _mensajes.add(_crearMensaje("Coeficientes", coeficientes.toString()));
    });

    for (int i = 1; i <= valorIndependiente.abs(); i++) {
      if (valorIndependiente % i == 0) {
        divisoresPositivos.add(i);
      }
    }

    for (int i = 1; i <= valorIndependiente.abs(); i++) {
      if (valorIndependiente % i == 0) {
        divisoresNegativos.add(-i);
      }
    }

    for (var divisor in divisoresPositivos) {
      _procesarDivisionSintetica(coeficientes, divisor, resultados, raices);
      setState(() {
        _mensajes.add(_crearMensaje("Divisor positivo",
            "$divisor, Resultados: ${resultados.toString()}, Raices: ${raices.toString()}"));
      });
    }

    for (var divisor in divisoresNegativos) {
      _procesarDivisionSintetica(coeficientes, divisor, resultados, raices);
      setState(() {
        _mensajes.add(_crearMensaje("Divisor negativo",
            "$divisor, Resultados: ${resultados.toString()}, Raices: ${raices.toString()}"));
      });
    }
  }

  void _procesarDivisionSintetica(List<double> coeficientes, int divisor,
      List<double> resultados, List<int> raices) {
    print("Probando el divisor: $divisor");

    List<double> fila1 = [coeficientes[0]];
    for (int j = 1; j < coeficientes.length; j++) {
      double valorFila2 = fila1[j - 1] * divisor;
      double nuevoValor = coeficientes[j] + valorFila2;
      fila1.add(nuevoValor);
      print("Fila1 después del coeficiente $j: $fila1");
    }

    if (fila1.last == 0) {
      raices.add(divisor);
      resultados.clear();
      resultados.addAll(fila1);
      print("Raíz encontrada: $divisor");
    } else {
      print("No es raíz: $divisor");
    }
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
