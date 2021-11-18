import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class TituloSessao extends StatelessWidget {

  final String titulo;

  const TituloSessao({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        titulo.toUpperCase(),
        style: GoogleFonts.raleway(
          color: cor_do_app,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
