import 'package:flutter/material.dart';
import 'package:gus/agenda/temas.dart';


class Lista_de_temas extends StatefulWidget {
  final int preference_tema_menu;
  final Function(int) onUpdate;
  final Color color_de_fondo;
  const Lista_de_temas({Key key, this.color_de_fondo, this.onUpdate, this.preference_tema_menu}) : super(key: key);

  @override
  _Lista_de_temasState createState() => _Lista_de_temasState();
}

class _Lista_de_temasState extends State<Lista_de_temas> {

  @override
  Widget build(BuildContext context) {
    Widget back_black = Stack(
      children: [
        Transform.translate(
          offset: Offset(-20.0, 0.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, 0.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(20.0, 0.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(40.0, 0.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(60.0, 0.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(-20.0, 25.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, 25.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(20.0, 25.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(40.0, 25.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(60.0, 25.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(-20.0, 35.0),
          child: Container(
            height: 1.0,
            width: 20.0,
            color: Colors.grey,
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, 35.0),
          child: Container(
            height: 1.0,
            width: 20.0,
            color: Colors.grey,
          ),
        ),
        Transform.translate(
          offset: Offset(20.0, 35.0),
          child: Container(
            height: 1.0,
            width: 20.0,
            color: Colors.grey,
          ),
        ),
        Transform.translate(
          offset: Offset(40.0, 35.0),
          child: Container(
            height: 1.0,
            width: 20.0,
            color: Colors.grey,
          ),
        ),
        Transform.translate(
          offset: Offset(60.0, 35.0),
          child: Container(
            height: 1.0,
            width: 20.0,
            color: Colors.grey,
          ),
        ),
      ],
    );


    Widget back_back_black = Stack(
      children: [
        Transform.translate(
          offset: Offset(-20.0, -25.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, -25.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(20.0, -25.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(40.0, -25.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(60.0, -25.0),
          child: Container(
            height: 25.0,
            width: 20.0,
            color: widget.color_de_fondo,
          ),
        ),
        Transform.translate(
          offset: Offset(-20.0, -15.0),
          child: Container(
            height: 1.0,
            width: 20.0,
            color: Colors.grey,
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, -15.0),
          child: Container(
            height: 1.0,
            width: 20.0,
            color: Colors.grey,
          ),
        ),
        Transform.translate(
          offset: Offset(20.0, -15.0),
          child: Container(
            height: 1.0,
            width: 20.0,
            color: Colors.grey,
          ),
        ),
        Transform.translate(
          offset: Offset(40.0, -15.0),
          child: Container(
            height: 1.0,
            width: 20.0,
            color: Colors.grey,
          ),
        ),
        Transform.translate(
          offset: Offset(60.0, -15.0),
          child: Container(
            height: 1.0,
            width: 20.0,
            color: Colors.grey,
          ),
        ),
      ],
    );

    int int_initial_menu = widget.preference_tema_menu;

    //Color color_de_fondo = Colors.red;
    return Container(
      width: 90, height:  40,
      child: ListTile(
        leading: Transform.translate(offset: Offset(15.0, 0.0),child: iconos_temas[int_initial_menu]),
        trailing: DropdownButton<int>(
          onChanged: (int int_tema) {
            setState(() {
              int_initial_menu = int_tema;
            });

            widget.onUpdate(int_tema);
          },
          items: [
            DropdownMenuItem(
              value: 0,
              child: Stack(
                children: [
                  back_back_black,
                  back_black,
                  Center(child: iconos_temas[0]),],
              ), ),
            DropdownMenuItem(
              value: 1,
              child: Stack(
                children: [
                  back_black,
                  Center(child: iconos_temas[1]),],
              ), ),
            DropdownMenuItem(
              value: 2,
              child: Stack(
                children: [
                  back_black,
                  Center(child: iconos_temas[2]),],
              ), ),
            DropdownMenuItem(
              value: 3,
              child: Stack(
                children: [
                  back_black,
                  Center(child: iconos_temas[3])],
              ), ),
            DropdownMenuItem(
              value: 4,
              child: Stack(
                children: [
                  back_black,
                  Center(child: iconos_temas[4]),],
              ), ),
            DropdownMenuItem(
              value: 5,
              child: Stack(
                children: [
                  back_black,
                  Center(child: iconos_temas[5]),],
              ), ),
            DropdownMenuItem(
              value: 6,
              child: Stack(
                children: [
                  back_black,
                  Center(child: iconos_temas[6]),],
              ), ),
            DropdownMenuItem(
              value: 7,
              child: Stack(
                children: [
                  back_black,
                  Center(child: iconos_temas[7])],
              ), ),
            DropdownMenuItem(
              value: 8,
              child: Stack(
                children: [
                  back_black,
                  Center(child: iconos_temas[8])
                  ,],
              ), ),
            DropdownMenuItem(
              value: 9,
              child: Stack(
                children: [
                  back_black,
                  Center(child: iconos_temas[9]),],
              ), ),
            DropdownMenuItem(
              value: 10,
              child: Stack(
                children: [
                  back_black,
                  Center(child: iconos_temas[10]),],
              ), ),
            DropdownMenuItem(
              value: 11,
              child: Stack(
                children: [
                  back_black,
                  Center(child: iconos_temas[11]),],
              ), ),
          ],
        ),
      ),
    );
    
    
  }
}

