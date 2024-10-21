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
  var img = 'assets/02.png';

  void _savePolinomio() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Polinomio polinomio = Polinomio(
        grado: _grado,
        coeficientes: _coeficientes,
      );

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
      appBar: AppBar(
        title: const Text('GRADO DE LA ECUACIÓN',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: SizedBox(
                          width: constraints.maxWidth < 600 ? 150 : 300,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Ej. 3',
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  img = 'assets/monaChinaNo.png';
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.all(100),
                                  content: Text(
                                    'Por favor ingresa el grado',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ));
                                return '';
                              }
                              if (!RegExp(r'^[a-zA-Z0-9]*([2-9]|[1-9][0-9])$')
                                  .hasMatch(value)) {
                                setState(() {
                                  img = 'assets/monaChinaNo.png';
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.all(100),
                                        content: Text(
                                          'Por favor ingresa un grado válido.',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )));
                                return '';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _grado = int.tryParse(value) ?? 0;
                                _coeficientes =
                                    List<double>.filled(_grado + 1, 0);
                              });
                            },
                            onFieldSubmitted: (value) {
                              _savePolinomio();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      constraints.maxWidth < 600
                          ? Column(
                              children: [
                                ElevatedButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(16.0),
                                    backgroundColor:
                                        const Color.fromRGBO(225, 28, 28, 0.98),
                                    shadowColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PaginaBienvenida(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Volver",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Image(
                                  image: AssetImage(img),
                                  width: 200,
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.all(16.0),
                                    backgroundColor: Colors.white,
                                    overlayColor: Colors.red,
                                  ),
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
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(16.0),
                                    backgroundColor:
                                        const Color.fromRGBO(225, 28, 28, 0.98),
                                    shadowColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PaginaBienvenida(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Volver",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Center(
                                  child: Image(
                                    image: AssetImage(img),
                                    width: 200,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.all(16.0),
                                    backgroundColor: Colors.white,
                                    overlayColor: Colors.red,
                                  ),
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
            ),
          );
        },
      ),
    );
  }
}
