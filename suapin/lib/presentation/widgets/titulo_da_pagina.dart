import 'package:flutter/material.dart';

class TituloDaPagina extends StatelessWidget {
  final String titulo;
  final String? textoAuxiliar;
  final String? usuario;
  final bool showAvatar;
  final double avatarRadius;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  const TituloDaPagina({
    super.key,
    required this.titulo,
    this.textoAuxiliar,
    this.usuario,
    this.showAvatar = true,
    this.avatarRadius = 24,
    this.trailing,
    this.padding = const EdgeInsets.only(bottom: 24.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (textoAuxiliar != null) ...[
                Text(
                  _buildAuxText(),
                  style: const TextStyle(
                    color: Color(0xFF059669),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
              ],
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          if (trailing != null)
            trailing!
          else if (showAvatar)
            CircleAvatar(
              radius: avatarRadius,
              backgroundColor: Colors.grey.shade200,
              child: ClipOval(
                child: Image.network(
                  'https://github.com/isaaclira.png',
                  width: avatarRadius * 2,
                  height: avatarRadius * 2,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback para evitar NetworkImageLoadException
                    return Icon(
                      Icons.person,
                      size: avatarRadius,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _buildAuxText() {
    if (usuario == null || usuario!.isEmpty) {
      return textoAuxiliar!;
    }

    return "${textoAuxiliar!}, ${usuario!}";
  }
}
