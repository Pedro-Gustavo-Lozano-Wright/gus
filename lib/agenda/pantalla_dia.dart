import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gus/agenda/bloc/agenda_bloc.dart';
import 'package:gus/agenda/reorderable_list.dart';
import 'package:gus/agenda/shared_preferences.dart';
import 'package:gus/agenda/temas.dart';
import 'package:gus/agenda/variables_globales.dart';
import 'package:gus/db_meta/modelo_meta.dart';
import 'package:hive/hive.dart';

import '../caja_de_arena.dart';
import '../desplegable.dart';
import 'menu_temas.dart';


class Pantalla_day extends StatefulWidget {
  final Color color_de_fondo;
  final double h_pantalla;

  const Pantalla_day({Key key, this.color_de_fondo, this.h_pantalla,}) : super(key: key);
  @override
  _Pantalla_dayState createState() => _Pantalla_dayState();
}

class _Pantalla_dayState extends State<Pantalla_day>
    with WidgetsBindingObserver {

  int day_ofset = 0;
  AgendaBloc agendaBloc;

  double w_pantalla = 1.0;
  double h_pantalla = 1.0;

  List<String> list_day = [];

  bool num_u_hora = true;

  bool init_day = false;

  @override
  void initState() {
    super.initState();

    agendaBloc = BlocProvider.of<AgendaBloc>(context);

    Future.delayed(const Duration(milliseconds: 100), () async {
      day_ofset = await leer_preference_day_ofset();
      list_day = await leer_preference_day_hoy();
      num_u_hora = await leer_preference_num_u_hora();

    });


    Future.delayed(const Duration(milliseconds: 300), () {
      agendaBloc.add(LoadAgendaEvent());
    });


  }

  @override
  Widget build(BuildContext context) {
    w_pantalla = MediaQuery.of(context).size.width;
    w_pantalla = double.parse(w_pantalla.toStringAsFixed(0)) - 11;

    h_pantalla = MediaQuery.of(context).size.height;
    h_pantalla = double.parse(h_pantalla.toStringAsFixed(0)) - 55;


    return BlocBuilder<AgendaBloc, AgendaState>(
        builder: (context, state) {
          if (state is LoadAgendaState){
            return Container(
              color: widget.color_de_fondo,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5, left: 10),
                    child: desplegable(desplegado: false,
                      color_de_fondo: widget.color_de_fondo,
                      title: Row(
                        children: [
                          SizedBox(width: 10,),
                          Transform.translate(offset: Offset(0.0, 3.0),child:  Text("algo",style: TextStyle(color: Colors.grey),)),
                        ],
                      ),

                    ),
                  ),
                  Container(
                    child: Expanded(flex: 1,
                      child: Container(
                        child: ReorderableListView.builder(
                          scrollController: ScrollController(keepScrollOffset: true),
                          shrinkWrap: true,
                          //physics: NeverScrollableScrollPhysics(),
                          onReorder: _onReorder,
                          scrollDirection: Axis.vertical,
                          itemCount: list_day.length,
                          itemBuilder: (BuildContext context, int index) { return ListViewCard(
                            color_de_fondo: widget.color_de_fondo,
                              day_ofset: day_ofset,
                              w_pantalla: w_pantalla,
                              key: Key('$index'),
                              index: index,
                              num_u_hora: num_u_hora,
                              list_day: list_day
                          ); },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 25,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            /*Container(
                              width: 10,
                              height: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Container(
                                width: 20,
                                color: widget.color_de_fondo,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(0),
                                    primary: widget.color_de_fondo,
                                  ),
                                  child: Icon(
                                    Icons.access_time,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    if (num_u_hora) {
                                      num_u_hora = false;
                                      guardar_preference_num_u_hora(num_u_hora);
                                    } else {
                                      num_u_hora = true;
                                      guardar_preference_num_u_hora(num_u_hora);
                                    }
                                    agendaBloc.add(LoadAgendaEvent());
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: 10,
                              height: 1,
                            ),
                            Container(
                              color:widget.color_de_fondo,
                              width: !num_u_hora ? 30 : 0,
                              height: 20,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(0),
                                    primary: widget.color_de_fondo,
                                    side: BorderSide(color: Colors.grey)),
                                child: Transform.translate(
                                    offset: Offset(0, -2),
                                    child: !num_u_hora
                                        ? Icon(
                                      Icons.keyboard_arrow_up,
                                      color: Colors.grey,
                                    )
                                        : Container()),
                                onPressed: () {
                                  day_ofset = day_ofset + 10;
                                  guardar_preference_day_ofset(day_ofset);
                                  agendaBloc.add(LoadAgendaEvent());
                                },
                              ),
                            ),
                            Container(
                              width: !num_u_hora ? 10 : 0,
                              height: 1,
                            ),
                            Container(
                              color:widget.color_de_fondo,
                              width: !num_u_hora ? 40 : 0,
                              height: 20,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(0),
                                    primary: widget.color_de_fondo,
                                    side: BorderSide(color: Colors.grey)),
                                child: Text(
                                  "Now",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 13),
                                ),
                                onPressed: () {
                                  var now = DateTime.now();
                                  int minDeHoraAhora = now.hour * 60;
                                  int minAhora = now.minute - ((now.minute) % 10);
                                  day_ofset = minDeHoraAhora + minAhora;
                                  guardar_preference_day_ofset(day_ofset);
                                  agendaBloc.add(LoadAgendaEvent());
                                },
                              ),
                            ),
                            Container(
                              width: !num_u_hora ? 10 : 0,
                              height: 1,
                            ),
                            Container(
                              color:widget.color_de_fondo,
                              width: !num_u_hora ? 30 : 0,
                              height: 20,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(0),
                                    primary: widget.color_de_fondo,
                                    side: BorderSide(color: Colors.grey)),
                                child: Transform.translate(
                                    offset: Offset(0, -2),
                                    child: !num_u_hora
                                        ? Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.grey,
                                    )
                                        : Container()),
                                onPressed: () {
                                  day_ofset = day_ofset - 10;
                                  guardar_preference_day_ofset(day_ofset);
                                  agendaBloc.add(LoadAgendaEvent());
                                },
                              ),
                            ),*/
                          ],
                        ),
                        Row(
                            textDirection: TextDirection.rtl,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              /*Container(
                                color:widget.color_de_fondo,
                                height: 20,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      primary: widget.color_de_fondo,
                                      side: BorderSide(color: Colors.grey)),
                                  child: Text(
                                    "hive",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 13),
                                  ),
                                  onPressed: () {


                                  },
                                ),
                              ),*/
                              Container(
                                width: 10,
                                height: 1,
                              ),
                             /* Container(
                                color:widget.color_de_fondo,
                                height: 20,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      primary: widget.color_de_fondo,
                                      side: BorderSide(color: Colors.grey)),
                                  child: Text(
                                    hoy_day,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 13),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => sub_arbol_menu()),);

                                  },
                                ),
                              ),*/
                              Container(
                                width: 10,
                                height: 1,
                              ),
                              Container(
                                color:widget.color_de_fondo,
                                height: 20,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      primary: widget.color_de_fondo,
                                      side: BorderSide(color: Colors.grey)),
                                  child: Text(
                                    "guardar",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 13),
                                  ),
                                  onPressed: () {


                                    AgendaBloc agendaBloc;
                                    agendaBloc = BlocProvider.of<AgendaBloc>(context);

                                    Meta meta1 = Meta(titulo: "jiji", descripcion: "gab");
                                    agendaBloc.add(salvePersonEvent(meta: meta1));



                                    //Persona item = Persona(age: 25, name: "gus");addItem(item);
                                  },
                                ),
                              ),
                              Container(
                                width: 10,
                                height: 1,
                              ),
                              Container(
                                color:widget.color_de_fondo,
                                height: 20,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      primary: widget.color_de_fondo,
                                      side: BorderSide(color: Colors.grey)),
                                  child: Text(
                                    "leer",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 13),
                                  ),
                                  onPressed: () {

                                    AgendaBloc agendaBloc;
                                    agendaBloc = BlocProvider.of<AgendaBloc>(context);
                                    agendaBloc.add(getPersonEvent());

                                    //Persona item = Persona(age: 25, name: "tavo");updateItem(0,item);

                                  },
                                ),
                              ),
                              Container(
                                width: 10,
                                height: 1,
                              ),
                              Container(
                                color:widget.color_de_fondo,
                                height: 20,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      primary: widget.color_de_fondo,
                                      side: BorderSide(color: Colors.grey)),
                                  child: Text(
                                    "añadir",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 13),
                                  ),
                                  onPressed: () {

                                    AgendaBloc agendaBloc;
                                    agendaBloc = BlocProvider.of<AgendaBloc>(context);

                                    Meta subMeta = Meta(titulo: "submeta jiji", descripcion: "sub descrip jiji");
                                    agendaBloc.add(addSubMetaEvent(subMeta: subMeta));


                                  },
                                ),
                              ),
                              Container(
                                width: 10,
                                height: 1,
                              ),

                              Container(
                                width: 10,
                                height: 1,
                              ),
                            ]),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }else{return Container();}
        },
      );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final String item = list_day.removeAt(oldIndex);
        list_day.insert(newIndex, item);
      },
    );
    guardar_day(list_day);
    Future.delayed(const Duration(milliseconds: 1000), () {
      agendaBloc.add(LoadAgendaEvent());
    });
  }

}


