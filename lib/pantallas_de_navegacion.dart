import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gus/desplegable.dart';
import 'package:gus/agenda/fechas.dart';
import 'package:gus/agenda/shared_preferences.dart';
import 'package:gus/agenda/temas.dart';

import 'agenda/bloc/agenda_bloc.dart';
import 'agenda/menu_temas.dart';
import 'agenda/pantalla_dia.dart';
import 'metas/pantalla_metas.dart';

class pantalla_de_navegacion extends StatefulWidget {
  final Color color_de_fondo;
  const pantalla_de_navegacion({Key key, this.color_de_fondo}) : super(key: key);

  @override
  _pantalla_de_navegacionState createState() => _pantalla_de_navegacionState();
}

class _pantalla_de_navegacionState extends State<pantalla_de_navegacion> {
  @override

  int teclado = 0;
  int tabIndex = 0;
  int menu_tema = 0;
  String hoy_day = "";

  double h_pantalla = 500;
  double w_pantalla = 300;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () async {
      menu_tema = await leer_preference_menu_tema();
      h_pantalla = MediaQuery.of(context).size.height;
      w_pantalla = MediaQuery.of(context).size.width;
    });
    setState(() {
      hoy_day = tener_fecha();
    });

  }

  Widget build(BuildContext context) {

    final List<Widget> tabPages = [
      Pantalla_day(color_de_fondo: widget.color_de_fondo),
      Pantalla_metas(color_de_fondo: widget.color_de_fondo, h_pantalla: (h_pantalla - teclado),w_pantalla: w_pantalla,),
      Center(child: Text("2")),
      Center(child: Text("3")),
    ];

    final List<Widget> bottonNavBar = [
      Container(child: TextButton(child: Container(height: 35, child: Text( "Dia", style: TextStyle(color: tabIndex == 0? Colors.grey[300] : Colors.grey),)),onPressed: (){setState(() {tabIndex = 0;});},)),
      Container(child: TextButton(child: Container(height: 35, child: Text( "Metas", style: TextStyle(color: tabIndex == 1? Colors.grey[300] : Colors.grey),)),onPressed: (){setState(() {tabIndex = 1;});},)),
      Container(child: TextButton(child: Container(height: 35, child: Text( "Recursos", style: TextStyle(color: tabIndex == 2? Colors.grey[300] : Colors.grey),)),onPressed: (){setState(() {tabIndex = 2;});},)),
      Container(child: TextButton(child: Container(height: 35, child: Text( "Estadisticas", style: TextStyle(color: tabIndex == 3? Colors.grey[300] : Colors.grey),)),onPressed: (){setState(() {tabIndex = 3;});},)),
      //Container(child: TextButton(child: Container(height: 35, child: Text( "b", style: TextStyle(color: tabIndex == 4? Colors.grey[300] : Colors.grey),)),onPressed: (){setState(() {tabIndex = 4;});},)),
      //Container(child: TextButton(child: Container(height: 35, child: Text( "c", style: TextStyle(color: tabIndex == 5? Colors.grey[300] : Colors.grey),)),onPressed: (){setState(() {tabIndex = 5;});},)),
    ];

    var now = DateTime.now();
    var born = DateTime.utc(1996, 1, 26);
    var time_avilable = now.difference(born.add(Duration(days: (365 * 100) + 25)));
    var time_avilable_mitad = now.difference(born.add(Duration(days: (365 * 50) + 13)));
    var time_avilable_treinta = now.difference(born.add(Duration(days: (365 * 30) + 7)));//10^6
    //var time_avilable_29 = now.difference(born.add(Duration(days: (365 * 30) + 7)));//10^5
    //var time_avilable_28 = now.difference(born.add(Duration(days: (365 * 30) + 7)));//10^4
    //var time_avilable_27 = now.difference(born.add(Duration(days: (365 * 30) + 7)));//10^3
    var time_avilable_26 = now.difference(born.add(Duration(days: (365 * 26) + 6)));//10^2
    //25 10^1


    String t_a = time_avilable.inDays.toString().substring(1);
    String t_a_m = time_avilable_mitad.inDays.toString().substring(1);
    String t_a_30 = time_avilable_treinta.inDays.toString().substring(1);
    String t_a_26 = time_avilable_26.inDays.toString().substring(1);

    t_a = t_a.substring(0,2) + " , " + t_a.substring(2);
    t_a_m = t_a_m.substring(0,1) + " , " + t_a_m.substring(1);
    t_a_30 = t_a_30.substring(0,1) + " , " + t_a_30.substring(1);
    //t_a_26 = t_a_26.substring(0,0) + " , " + t_a_26.substring(1);

    Widget tiempo_limite = Container(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text( t_a + "  dias antes de morir (100)" ,style: TextStyle(color: Colors.grey),),
        Text("  " + t_a_m + "  dias antes de restart (50)",style: TextStyle(color: Colors.grey),),
        Text("  " + t_a_30 + "  dias para 10^6 Dolar (30)",style: TextStyle(color: Colors.grey),),
        Text("       " + t_a_26 + "  dias para 10^2 Dolar (26)",style: TextStyle(color: Colors.grey),),
      ],
    ),);

    return BlocBuilder<AgendaBloc, AgendaState>(
      builder: (context, state) {
        return Container(color: widget.color_de_fondo,
          child: Column(
            children: [
              Container(height: 20, color: widget.color_de_fondo,),
              Container(color: widget.color_de_fondo, padding: EdgeInsets.only(right: 5),
                child: desplegable(
                  desplegado: false,
                  title: Row(
                    children: [
                      Transform.translate(offset: Offset(-20.0, -5.0),child: Stack(
                        children: [
                          Lista_de_temas(color_de_fondo: widget.color_de_fondo,
                            preference_tema_menu: menu_tema,
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
                      Transform.translate(offset: Offset(-20.0, 0.0),child:
                      Container(width: w_pantalla -115,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(titulos_temas[menu_tema],style: TextStyle(color: Colors.grey),),
                                Text(titulos_temas[menu_tema],style: TextStyle(color: Colors.grey),),
                              ],
                            ),
                            Column(
                              children: [
                                Text(hoy_day,style: TextStyle(color: Colors.grey),),
                                Text("titulos]",style: TextStyle(color: Colors.grey),),
                              ],
                            ),
                            Column(
                              children: [
                                Text("j",style: TextStyle(color: Colors.grey),),
                                Text("hjb",style: TextStyle(color: Colors.grey),),
                              ],
                            ),
                          ],
                        ),
                      )
                      ),
                    ],
                  ),
                  color_de_fondo: widget.color_de_fondo,
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tiempo_limite,
                        Container(height: 5,),
                        Container(height: 1, color: Colors.grey)
                      ],
                    ),
                  ),
                ),
              ),
              Container(height: h_pantalla -(95 + teclado),child: tabPages[tabIndex]),
              Container(height: 35, color: widget.color_de_fondo,
                child: Row(
                  children: [
                    Container(width: w_pantalla - 60,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: bottonNavBar,
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Transform.rotate(angle: 3.1416, child: Container(width: 20, height: 20,child: TextButton(style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)), onPressed: (){setState(() {teclado = 250;});}, child: Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.grey,size: 20,)))),
                          SizedBox(  width: 10,),
                          Container(width: 20, height: 20,child: TextButton(style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)), onPressed: (){setState(() {teclado = 0;});}, child: Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.grey, size: 20,))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
