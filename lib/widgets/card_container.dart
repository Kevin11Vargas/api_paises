import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(0),
        decoration: _createCardShape(),
        child: this.child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
          color: const Color.fromARGB(31, 255, 255, 255),//colorea todo el cuadrante 
          borderRadius: BorderRadius.circular(0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(31, 255, 255, 255),
              blurRadius: 15,
              offset: Offset(0, 5),
            )
          ]);
}
