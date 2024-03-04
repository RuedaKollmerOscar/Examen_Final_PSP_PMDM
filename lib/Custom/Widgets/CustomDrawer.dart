import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final List<Widget> children;
  final String sName;
  final String sUsername;
  final void Function(int indice)? fOnItemTap;

  const CustomDrawer({
    Key? key,
    required this.fOnItemTap,
    this.children = const [],
    this.sName = "Invitado",
    this.sUsername = "Usuario Invitado",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(sName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              accountEmail: Text('@$sUsername',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background
              ),
            ),

            Divider(
              color: Theme.of(context).colorScheme.inversePrimary,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                leading: Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  "Productos destacados",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () => fOnItemTap!(0),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                leading: Icon(
                  Icons.search_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Buscar un producto',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () => fOnItemTap!(1),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  "Mi cuenta",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () => fOnItemTap!(2),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                leading: Icon(
                  Icons.map_sharp,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Encuentra nuestras tiendas',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () => fOnItemTap!(3),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                leading: Icon(
                  Icons.info_outline_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Sobre nosotros',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () => fOnItemTap!(4),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                title: Text(
                  'Cerrar Sesión',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () => fOnItemTap!(5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
