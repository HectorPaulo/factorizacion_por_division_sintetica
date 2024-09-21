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
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Por favor ingresa el grado')));
                        return '';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9]*([2-9]|[1-9][0-9])$')
                          .hasMatch(value)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Por favor ingresa un grado válido.')));
                        return '';
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
                    onFieldSubmitted: (value) {
                      _savePolinomio();
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
                    child: const Text(
                      "Volver",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Center(
                    child: Image(
                      image: AssetImage('assets/02.png'),
                      width: 300,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _savePolinomio,
                    child: const Text(
                      'Siguiente',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
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
