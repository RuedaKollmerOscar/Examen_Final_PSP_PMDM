import 'package:flutter/material.dart';

class CustomBottomMenu extends StatelessWidget {
  const CustomBottomMenu({Key? key, required this.fOnItemTap}) : super(key: key);
  final Function(int indice)? fOnItemTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.inversePrimary,
              width: 0.2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => fOnItemTap!(0),
                icon: Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                label: Text(
                  "Destacados",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => fOnItemTap!(1),
                icon: Icon(
                  Icons.category,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                label: Text(
                  "Categorías",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => fOnItemTap!(2),
                icon: Icon(
                  Icons.shopping_cart,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                label: Text(
                  "Mis Productos",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}