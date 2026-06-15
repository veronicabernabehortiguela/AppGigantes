// ===============================
// widgets/boton_idioma.dart
// ===============================

import 'package:flutter/material.dart';
import '../modelos/idioma.dart';

class BotonIdioma extends StatelessWidget {

  final Idioma idioma;

  final VoidCallback alPulsar;

  const BotonIdioma({

    super.key,

    required this.idioma,

    required this.alPulsar,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: alPulsar,

      child: Container(

        width: 120,
        height: 120,

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(20),

          image: DecorationImage(

            image: AssetImage(idioma.bandera),

            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}