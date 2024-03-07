import 'package:flutter/material.dart';

class CustomBottomMenu extends StatelessWidget {
  const CustomBottomMenu({Key? key, required this.fOnItemTap}) : super(key: key);
  final Function(int indice)? fOnItemTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.inversePrimary,
            width: 0.2,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton.icon(
                onPressed: () => fOnItemTap!(0),
                icon: Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                label: Text(
                  "Favoritos",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 10,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton.icon(
                onPressed: () => fOnItemTap!(1),
                icon: Icon(
                  Icons.category,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                label: Text(
                  "Categorías",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 10,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton.icon(
                onPressed: () => fOnItemTap!(2),
                icon: Icon(
                  Icons.add_box,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                label: Text(
                  "Sube un Producto",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 10,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}