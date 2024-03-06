import 'package:flutter/material.dart';
import 'package:techshop/Custom/Widgets/CustomAppBar.dart';

class SobreNosotrosView extends StatelessWidget {
  const SobreNosotrosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Sobre Nosotros'),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Acerca de TechShop",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "TechShop es tu tienda de confianza para componentes informáticos. Ofrecemos un catálogo de productos en línea y también te brindamos la oportunidad de subir tus propios productos a nuestra plataforma.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Misión",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Nuestra misión es proporcionar a nuestros clientes acceso fácil y rápido a los mejores componentes informáticos del mercado. Buscamos ser el referente en la industria, ofreciendo productos de calidad y una experiencia de compra excepcional.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Visión",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Queremos ser reconocidos como líderes en el mundo de la tecnología, destacándonos por la variedad de nuestro catálogo, la excelencia en el servicio al cliente y la satisfacción de aquellos que confían en TechShop para sus necesidades informáticas.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}