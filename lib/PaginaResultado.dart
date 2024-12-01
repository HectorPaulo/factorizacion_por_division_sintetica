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
  List<double> _raices = [];

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
    List<double> coeficientes = List.from(widget.polinomio.coeficientes);
    double valorIndependiente = coeficientes.last;
    double coeficientePrincipal = coeficientes.first;
    List<double> divisores = [];

    // Generar divisores fraccionarios: término independiente / coeficiente principal
    List<int> divisoresIndependiente =
        _obtenerDivisores(valorIndependiente.abs().toInt());
    List<int> divisoresPrincipal =
        _obtenerDivisores(coeficientePrincipal.abs().toInt());

    for (int num in divisoresIndependiente) {
      for (int denom in divisoresPrincipal) {
        divisores.add(num / denom);
        divisores.add(-num / denom);
      }
    }

    // Eliminar duplicados en divisores
    divisores = divisores.toSet().toList();

    // Probar divisores y buscar raíces repetidas
    for (var divisor in divisores) {
      while (true) {
        List<double> resultados = [];
        List<double> fila2 = [];
        bool esRaiz = _procesarDivisionSintetica(
            coeficientes, divisor, resultados, fila2);

        if (esRaiz) {
          setState(() {
            _raices.add(divisor); // Agregar la raíz repetida
            _mensajes.add(Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _crearMensaje("$divisor", ""),
                    const Icon(Icons.navigate_next, color: Colors.amber),
                    Text(
                      "${coeficientes.toString()} ",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'Monaspace Neon',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "${fila2.toString()} ",
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Monaspace Neon'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${resultados.toString()} ",
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Monaspace Neon'),
                      ),
                    ),
                    Icon(Icons.check, color: Colors.green),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ));
          });
          coeficientes =
              List.from(resultados.sublist(0, resultados.length - 1));
        } else {
          break; // Salir si ya no es raíz
        }
      }
    }
  }

  List<int> _obtenerDivisores(int numero) {
    List<int> divisores = [];
    for (int i = 1; i <= numero; i++) {
      if (numero % i == 0) {
        divisores.add(i);
      }
    }
    return divisores;
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

    if (fila1.last.abs() < 1e-10) {
      resultados.addAll(fila1);
      return true;
    }
    resultados.addAll(fila1);
    return false;
  }

  Widget _crearMensaje(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
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
      ),
    );
  }
}
