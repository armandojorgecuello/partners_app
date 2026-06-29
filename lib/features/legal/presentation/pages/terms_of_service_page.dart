import 'package:flutter/material.dart';
import 'package:partners_app/core/locale/app_locale.dart';
import 'package:partners_app/core/theme/app_colors.dart';

/// Relocated from lib/src/pages/more/terms_services_page.dart.
class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(localizations?.t('termServ.title') ?? ''),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        backgroundColor: AppColors.pageDark,
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Text(
            // TODO: reemplazar con el texto real de los terminos de servicio.
            'Pendiente: agregar aquí el texto real de los términos de servicio.',
            style: TextStyle(color: Colors.white, fontSize: 14.0),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
