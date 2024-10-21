import 'package:factorizacion_por_division_sintetica/PaginaDefinirGradoEcuacion.dart';
import 'package:flutter/material.dart';
import 'package:factorizacion_por_division_sintetica/polinomio.dart';
import 'PaginaAceptarEcuacion.dart';

class PaginaCrearEcuacion extends StatefulWidget {
  final Polinomio polinomio;

  const PaginaCrearEcuacion({super.key, required this.polinomio});

  @override
  State<PaginaCrearEcuacion> createState() => _PaginaCrearEcuacionState();
}

class _PaginaCrearEcuacionState extends State<PaginaCrearEcuacion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes =
        List.generate(widget.polinomio.grado + 1, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int grado = widget.polinomio.grado;
    var coeficientes = widget.polinomio.coeficientes;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text(
          'C R E A R   E C U A C I Ó N',
          style: TextStyle(
              fontSize: 30, fontFamily: 'Arial', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          (grado + 1), // Incluye el término independiente
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 10.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                i < grado
                                    ? 'Coeficiente de X^${grado - i}'
                                    : 'Término independiente',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: constraints.maxWidth < 600 ? 100 : 150,
                                child: TextFormField(
                                  focusNode: _focusNodes[i],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: 'Ej. ${grado - i}',
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.red,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: EdgeInsets.all(200),
                                              content: Text(
                                                'Por favor ingresa el coeficiente',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )));
                                      return '';
                                    }
                                    if (!RegExp(r'^-?[0-9]+(\.[0-9]+)?$')
                                        .hasMatch(value)) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.red,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: EdgeInsets.all(200),
                                              content: Text(
                                                'Por favor ingresa un número válido',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )));
                                      return '';
                                    }
                                    if (double.parse(value) > 99999) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.red,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: EdgeInsets.all(200),
                                              content: Text(
                                                'El número es demasiado grande',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )));
                                      return '';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    coeficientes[i] =
                                        double.tryParse(value) ?? 0.0;
                                    print("Coeficientes: $coeficientes");
                                    print("Índice: $i");
                                    print("Valor: $value");
                                  },
                                  onFieldSubmitted: (value) {
                                    if (i < grado) {
                                      FocusScope.of(context)
                                          .requestFocus(_focusNodes[i + 1]);
                                    } else {
                                      if (_formKey.currentState!.validate()) {
                                        Polinomio polinomio = Polinomio(
                                          grado: grado,
                                          coeficientes: coeficientes,
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PaginaAceptarEcuacion(
                                                    polinomio: polinomio),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          backgroundColor: Color.fromRGBO(225, 28, 28, 0.98),
                          shadowColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PaginaDefinirGradoEcuacion()));
                        },
                        child: const Text(
                          'Volver',
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                          width: 20), // Adjusted spacing for responsiveness
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Polinomio polinomio = Polinomio(
                              grado: grado,
                              coeficientes: coeficientes,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PaginaAceptarEcuacion(polinomio: polinomio),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Guardar',
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
