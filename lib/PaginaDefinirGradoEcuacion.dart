import 'package:flutter/material.dart';
import 'package:factorizacion_por_division_sintetica/polinomio.dart';
import 'PaginaCrearEcuacion.dart';
import 'PaginaBienvenida.dart';

class PaginaDefinirGradoEcuacion extends StatefulWidget {
  const PaginaDefinirGradoEcuacion({super.key});

  @override
  State<PaginaDefinirGradoEcuacion> createState() =>
      _PaginaDefinirGradoEcuacionState();
}

class _PaginaDefinirGradoEcuacionState
    extends State<PaginaDefinirGradoEcuacion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _grado = 0;
  List<double> _coeficientes = [];
  final double _valorIndependiente = 0;

  void _savePolinomio() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Polinomio polinomio = Polinomio(
        grado: _grado,
        coeficientes: _coeficientes,
        valorIndependiente: _valorIndependiente,
      );

      // Navegar a la página de creación de ecuación, pasando el Polinomio
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaginaCrearEcuacion(polinomio: polinomio),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Grado de la Ecuación',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SizedBox(
                  width: 150,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Ej. 3',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa el grado';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _grado = int.tryParse(value) ?? 0;
                        _coeficientes = List<double>.filled(
                            _grado + 1, 0); // Inicializar coeficientes
                      });
                    },
                  ),
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
                          builder: (context) => const PaginaBienvenida(),
                        ),
                      );
                    },
                    child: const Text("Volver"),
                  ),
                  const SizedBox(width: 80),
                  ElevatedButton(
                    onPressed: _savePolinomio,
                    child: const Text('Siguiente'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
