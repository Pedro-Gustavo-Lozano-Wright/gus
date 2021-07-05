import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gus/agenda/bloc/agenda_bloc.dart';
import 'package:gus/agenda/reorderable_list.dart';
import 'package:gus/agenda/shared_preferences.dart';
import 'package:gus/agenda/variables_globales.dart';

class pantalla_day extends StatefulWidget {
  @override
  _pantalla_dayState createState() => _pantalla_dayState();
}

class _pantalla_dayState extends State<pantalla_day>
    with WidgetsBindingObserver {

  int day_ofset = 0;

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
      num_u_hora = await leer_preference_num_u_hora();
    });


    Future.delayed(const Duration(milliseconds: 300), () {
      agendaBloc.add(LoadAgendaEvent());
    });

    var now_time = DateTime.now();
    String stri_dey_week = "";
    if (now_time.weekday == 0) {
      stri_dey_week = "Sun";
    } else if (now_time.weekday == 1) {
      stri_dey_week = "Mon";
    } else if (now_time.weekday == 2) {
      stri_dey_week = "Tue";
    } else if (now_time.weekday == 3) {
      stri_dey_week = "Wed";
    } else if (now_time.weekday == 4) {
      stri_dey_week = "Thu";
    } else if (now_time.weekday == 5) {
      stri_dey_week = "Fri";
    } else if (now_time.weekday == 6) {
      stri_dey_week = "Sat";
    } else if (now_time.weekday == 7) {
      stri_dey_week = "Sun";
    }

    String stri_month = "";
    if (now_time.month == 0) {
      stri_month = "Jan";
    } else if (now_time.month == 1) {
      stri_month = "Feb";
    } else if (now_time.month == 2) {
      stri_month = "Mar";
    } else if (now_time.month == 3) {
      stri_month = "Apr";
    } else if (now_time.month == 4) {
      stri_month = "May";
    } else if (now_time.month == 5) {
      stri_month = "Jun";
    } else if (now_time.month == 6) {
      stri_month = "Jul";
    } else if (now_time.month == 7) {
      stri_month = "Aug";
    } else if (now_time.month == 8) {
      stri_month = "Sep";
    } else if (now_time.month == 9) {
      stri_month = "Oct";
    } else if (now_time.month == 10) {
      stri_month = "Nov";
    } else if (now_time.month == 11) {
      stri_month = "Dec";
    }

    setState(() {
      hoy_day = "   " +
          stri_dey_week +
          " " +
          now_time.day.toString() +
          " " +
          stri_month +
          "   "; //+ " " + now_time.hour.toString() + ":" + now_time.minute.toString();
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
              color: color_de_fondo,
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Container(
                        height: h_pantalla,
                        child: ReorderableListView(
                          scrollController: ScrollController(keepScrollOffset: true),
                          shrinkWrap: true,
                          //physics: NeverScrollableScrollPhysics(),
                          onReorder: _onReorder,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(0.0),
                          children: List.generate(
                            list_day.length,
                                (index) {
                              return ListViewCard(
                                day_ofset: day_ofset,
                                w_pantalla: w_pantalla,
                                key: Key('$index'),
                                index: index,
                                listItems: list_day,
                                num_u_hora: num_u_hora,
                                list_day: list_day
                              );
                            },
                          ),
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
                            Container(
                              width: 10,
                              height: 1,
                            ),
                            Container(
                              width: 20,
                              color: color_de_fondo,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                                  primary: Colors.black,
                                ),
                                child: Icon(
                                  Icons.access_time,
                                  size: 18,
                                  color: color_principal,
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
                            )
                          ],
                        ),
                        Row(
                            textDirection: TextDirection.rtl,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: 10,
                                height: 1,
                              ),
                              Container(
                                color: color_de_fondo,
                                height: 20,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      primary: Colors.black,
                                      side: BorderSide(color: Colors.grey)),
                                  child: Text(
                                    hoy_day,
                                    style: TextStyle(
                                        color: color_principal,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 13),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              Container(
                                width: 10,
                                height: 1,
                              ),
                              Container(
                                color: color_de_fondo,
                                width: 25,
                                height: 20,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      primary: Colors.black,
                                      side: BorderSide(color: Colors.grey)),
                                  child: Transform.translate(
                                      offset: Offset(0, 0),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: color_principal,
                                        size: 18,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      if (init_day) {
                                        init_day = false;
                                      } else {
                                        init_day = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: 10,
                                height: 1,
                              ),
                              Container(
                                color: color_de_fondo,
                                width: init_day ? 30 : 0,
                                height: 20,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      primary: Colors.black,
                                      side: BorderSide(color: Colors.grey)),
                                  child: Transform.translate(
                                      offset: Offset(0, -2),
                                      child: init_day
                                          ? Icon(
                                        Icons.keyboard_arrow_up,
                                        color: color_principal,
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
                                width: init_day ? 10 : 0,
                                height: 1,
                              ),
                              Container(
                                color: color_de_fondo,
                                width: init_day ? 40 : 0,
                                height: 20,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      primary: Colors.black,
                                      side: BorderSide(color: Colors.grey)),
                                  child: Text(
                                    "Now",
                                    style: TextStyle(
                                        color: color_principal,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 13),
                                  ),
                                  onPressed: () {
                                    var now = DateTime.now();
                                    int min_de_hora_ahora = now.hour * 60;
                                    int min_ahora = now.minute - ((now.minute) % 10);
                                    day_ofset = min_de_hora_ahora + min_ahora;
                                    guardar_preference_day_ofset(day_ofset);
                                    agendaBloc.add(LoadAgendaEvent());
                                  },
                                ),
                              ),
                              Container(
                                width: init_day ? 10 : 0,
                                height: 1,
                              ),
                              Container(
                                color: color_de_fondo,
                                width: init_day ? 30 : 0,
                                height: 20,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      primary: Colors.black,
                                      side: BorderSide(color: Colors.grey)),
                                  child: Transform.translate(
                                      offset: Offset(0, -2),
                                      child: init_day
                                          ? Icon(
                                        Icons.keyboard_arrow_down,
                                        color: color_principal,
                                      )
                                          : Container()),
                                  onPressed: () {
                                    day_ofset = day_ofset - 10;
                                    guardar_preference_day_ofset(day_ofset);
                                    agendaBloc.add(LoadAgendaEvent());
                                  },
                                ),
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
