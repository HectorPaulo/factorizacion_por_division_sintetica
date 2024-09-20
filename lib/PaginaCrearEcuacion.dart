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

  @override
  Widget build(BuildContext context) {
    final int grado = widget.polinomio.grado;
    List<int> coeficientes = widget.polinomio.coeficientes;
    int valorIndependiente = widget.polinomio.valorIndependiente;

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ingresa los coeficientes del polinomio',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: grado + 1, // Incluye el término independiente
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            i < grado
                                ? 'Coeficiente de X^${grado - i}'
                                : 'Término independiente',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: coeficientes[i].toString(),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Ej. 3',
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa el coeficiente';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                coeficientes[i] = int.tryParse(value) ?? 0;
                              });
                            },
                          ),
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PaginaDefinirGradoEcuacion()));
                    },
                    child: const Text('Volver'),
                  ),
                  const SizedBox(width: 80),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Polinomio polinomio = Polinomio(
                          grado: grado,
                          coeficientes: coeficientes,
                          valorIndependiente: valorIndependiente,
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
                    child: const Text('Guardar Ecuación'),
                  ),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
