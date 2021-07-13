import 'package:flutter/material.dart';
List<Widget> iconos_temas =
[
  Icon(Icons.fitness_center , color: Colors.blueGrey, size: 19,),
  Transform.rotate(angle: 3.1416,child:Icon(Icons.place_outlined, color: Colors.red),),
  Icon(Icons.favorite, color: Colors.pink),
  Icon(Icons.translate, color: Colors.purple[400]),
  Icon(Icons.precision_manufacturing, color: Colors.indigo[400]),
  Icon(Icons.flutter_dash, color: Colors.blue),
  Icon(Icons.laptop, color: Colors.cyan),
  Stack(
    children: [
      Transform.translate(offset: Offset(5.0, 5.0), child: Icon(Icons.play_arrow, color: Colors.teal, size: 13,)),
      Icon(Icons.smartphone_rounded, color: Colors.teal),
    ],
  ),
  Icon(Icons.emoji_food_beverage, color: Colors.green),
  Icon(Icons.attach_money, color: Colors.yellow),
  Text(" TF", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),),
  Transform.translate(offset: Offset(5.0, 0.0), child: Stack(
    children: [
      Transform.translate(offset: Offset(-7.0, 7.0), child: Icon(Icons.circle, color: Colors.blue, size: 10,),),
      Icon(Icons.circle, color: Colors.orange, size: 18,),
    ],
  ),),
];

List titulos_temas = [
  "Ejercicio",
  "PyTorch",
  "Amor",
  "Idiomas",
  "Proyectos",
  "Flutter",
  "Programacion",
  "Ocio",
  "Comida",
  "Dinero",
  "TensorFlow",
  "Keras",
];
