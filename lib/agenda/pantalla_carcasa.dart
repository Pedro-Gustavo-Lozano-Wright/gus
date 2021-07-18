import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gus/agenda/bloc/agenda_bloc.dart';
import 'package:gus/agenda/reorderable_list.dart';
import 'package:gus/agenda/shared_preferences.dart';
import 'package:gus/agenda/temas.dart';
import 'package:gus/agenda/variables_globales.dart';
import 'package:hive/hive.dart';

import 'caja_de_arena.dart';
import 'db_meta/modelo_meta.dart';
import 'desplegable.dart';
import 'menu_temas.dart';


class pantalla_day extends StatefulWidget {
  final Color color_de_fondo;

  const pantalla_day({Key key, this.color_de_fondo,}) : super(key: key);
  @override
  _pantalla_dayState createState() => _pantalla_dayState();
}

class _pantalla_dayState extends State<pantalla_day>
    with WidgetsBindingObserver {

  int day_ofset = 0;
  int menu_tema = 0;

  AgendaBloc agendaBloc;

  double w_pantalla = 1.0;
  double h_pantalla = 1.0;

  List<String> list_day = [];
  String hoy_day = "";

  bool num_u_hora = true;

  bool init_day = false;

  @override
  void initState() {
    super.initState();

    agendaBloc = BlocProvider.of<AgendaBloc>(context);

    Future.delayed(const Duration(milliseconds: 100), () async {
      day_ofset = await leer_preference_day_ofset();
      list_day = await leer_preference_day_hoy();
      menu_tema = await leer_preference_menu_tema();
      num_u_hora = await leer_preference_num_u_hora();

    });


    Future.delayed(const Duration(milliseconds: 300), () {
      agendaBloc.add(LoadAgendaEvent());
    });

    var nowTime = DateTime.now();
    String striDeyWeek = "";
    if (nowTime.weekday == 0) {
      striDeyWeek = "Sun";
    } else if (nowTime.weekday == 1) {
      striDeyWeek = "Mon";
    } else if (nowTime.weekday == 2) {
      striDeyWeek = "Tue";
    } else if (nowTime.weekday == 3) {
      striDeyWeek = "Wed";
    } else if (nowTime.weekday == 4) {
      striDeyWeek = "Thu";
    } else if (nowTime.weekday == 5) {
      striDeyWeek = "Fri";
    } else if (nowTime.weekday == 6) {
      striDeyWeek = "Sat";
    } else if (nowTime.weekday == 7) {
      striDeyWeek = "Sun";
    }

    String striMonth = "";
    if (nowTime.month == 0) {
      striMonth = "Jan";
    } else if (nowTime.month == 1) {
      striMonth = "Feb";
    } else if (nowTime.month == 2) {
      striMonth = "Mar";
    } else if (nowTime.month == 3) {
      striMonth = "Apr";
    } else if (nowTime.month == 4) {
      striMonth = "May";
    } else if (nowTime.month == 5) {
      striMonth = "Jun";
    } else if (nowTime.month == 6) {
      striMonth = "Jul";
    } else if (nowTime.month == 7) {
      striMonth = "Aug";
    } else if (nowTime.month == 8) {
      striMonth = "Sep";
    } else if (nowTime.month == 9) {
      striMonth = "Oct";
    } else if (nowTime.month == 10) {
      striMonth = "Nov";
    } else if (nowTime.month == 11) {
      striMonth = "Dec";
    }

    setState(() {
      hoy_day = "   " +
          striDeyWeek +
          " " +
          nowTime.day.toString() +
          " " +
          striMonth +
          "   "; //+ " " + now_time.hour.toString() + ":" + now_time.minute.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    w_pantalla = MediaQuery.of(context).size.width;
    w_pantalla = double.parse(w_pantalla.toStringAsFixed(0)) - 11;

    h_pantalla = MediaQuery.of(context).size.height;
    h_pantalla = double.parse(h_pantalla.toStringAsFixed(0)) - 55;


    var now = DateTime.now();
    var born = DateTime.utc(1996, 1, 26);

    var time_avilable = now.difference(born.add(Duration(days: (365 * 100) + 25)));
    var time_avilable_mitad = now.difference(born.add(Duration(days: (365 * 50) + 13)));
    var time_avilable_treinta = now.difference(born.add(Duration(days: (365 * 30) + 7)));//10^6
    //var time_avilable_29 = now.difference(born.add(Duration(days: (365 * 30) + 7)));//10^5
    //var time_avilable_28 = now.difference(born.add(Duration(days: (365 * 30) + 7)));//10^4
    //var time_avilable_27 = now.difference(born.add(Duration(days: (365 * 30) + 7)));//10^3
    var time_avilable_26 = now.difference(born.add(Duration(days: (365 * 30) + 7)));//10^2
    //25 10^1
    Widget tiempo_limite = Container(child: Column(
      children: [
        Text("${time_avilable.inDays} Dias antes de morir" ,style: TextStyle(color: Colors.grey),),
        Text("${time_avilable_mitad.inDays} Dias antes de caida, tiempo limite para restart",style: TextStyle(color: Colors.grey),),
        Text("${time_avilable_treinta.inDays} Dias para 10^6 Dolar",style: TextStyle(color: Colors.grey),),
        Text("${time_avilable_26.inDays} Dias para 10^2 Dolar (AI)",style: TextStyle(color: Colors.grey),),
      ],
    ),);


    return BlocBuilder<AgendaBloc, AgendaState>(
        builder: (context, state) {
          if (state is LoadAgendaState){
            return Container(
              color: widget.color_de_fondo,
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Container(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(right: 5, left: 10),
                    child: desplegable(
                      color_de_fondo: widget.color_de_fondo,
                      title: Row(
                        children: [
                          Stack(
                            children: [
                              Transform.translate(offset: Offset(-30.0, -5.0),child: Stack(
                                  children: [
                                    Lista_de_temas(color_de_fondo: widget.color_de_fondo,preference_tema_menu: menu_tema,
                                    onUpdate: (new_menu_tema){
                                      guardar_preference_menu_tema(new_menu_tema);
                                      menu_tema = new_menu_tema;
                                      AgendaBloc agendaBloc;
                                      agendaBloc = BlocProvider.of<AgendaBloc>(context);
                                      agendaBloc.add(TemaEvent());
                                    },),
                                    Transform.translate(offset: Offset(19.0, 38.0),child: Container(
                                      height: 4.0,
                                      width: 60.0,
                                      color: widget.color_de_fondo
                                    )),
                                  ],
                                ),
                              ),
                              Transform.translate(offset: Offset(45.0, 15.0),child:  Text(titulos_temas[menu_tema],style: TextStyle(color: Colors.grey),)),

                            ],
                          ),
                          SizedBox(width: 10,),
                          Transform.translate(offset: Offset(0.0, 3.0),child:  Text("algo",style: TextStyle(color: Colors.grey),)),
                        ],
                      ),
                      body: Column(
                        children: [
                          tiempo_limite,
                          Container(height: 1, color: Colors.grey)
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

                                    Meta meta1 = Meta(titulo: "jiji", descripcion: "gab", id: 24);
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

                                    Meta subMeta = Meta(titulo: "submeta jiji", descripcion: "sub descrip jiji", id: 3);
                                    agendaBloc.add(addSubMetaEvent(subMeta: subMeta));

                                    //Persona item = Persona(age: 25, name: "tavo");updateItem(0,item);

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


