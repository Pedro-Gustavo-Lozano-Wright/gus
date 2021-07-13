import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gus/agenda/shared_preferences.dart';
import 'package:gus/agenda/variables_globales.dart';

import 'bloc/agenda_bloc.dart';
import 'desplegable.dart';

class ListViewCard extends StatefulWidget {
  final Color color_de_fondo;
  final List<String> list_day;
  final double w_pantalla;
  final int day_ofset;
  final bool num_u_hora;
  final int index;
  final Key key;
  ListViewCard({this.index, this.key, this.num_u_hora, this.w_pantalla, this.day_ofset, this.list_day, this.color_de_fondo});

  @override
  _ListViewCard createState() => _ListViewCard();
}

class _ListViewCard extends State<ListViewCard> {

  AgendaBloc agendaBloc;
  TextEditingController texcontrol_1 = TextEditingController();
  Color color_day_now = Colors.grey;
  bool edit_acces = false;
  int fila_actual;
  double destacar_fila = 0.0;
  String color_secret = "0";
  String text_edit_text = "";
  FocusNode myFocusNode;
  int seg = 10;
  var now;

  @override
  void initState() {
    agendaBloc = BlocProvider.of<AgendaBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgendaBloc, AgendaState>(
      builder: (context, state) {
        if(state is LoadAgendaState){
          myFocusNode = FocusNode();
          myFocusNode.dispose();
          color_secret = widget.list_day[widget.index].substring(0,1);


          if(edit_acces_global == false){
            edit_acces = false;
            //myFocusNode.dispose();
          }

          if (color_secret == "1"){
            color_day_now = Colors.indigo[300];
          }else if (color_secret == "2"){
            color_day_now = Colors.green;
          }else if (color_secret == "3"){
            color_day_now = Colors.red[300];
          }else if (color_secret == "4"){
            color_day_now = Colors.purple[300];
          }else if (color_secret == "5"){
            color_day_now = Colors.cyan[600];
          }else if (color_secret == "6"){
            color_day_now = Colors.orange[600];
          }else if (color_secret == "7"){
            color_day_now = Colors.lime[700];
          }else if (color_secret == "8"){
            color_day_now = Colors.brown[300];
          }else if (color_secret == "9"){
            color_day_now = Colors.teal[400];
          }else if (color_secret == "0"){
            color_day_now = Colors.grey;
          }else {
            color_day_now = Colors.grey;
          }

          var now_time = DateTime.now();
          int min_de_hora_ahora = now_time.hour * 60;
          int min_ahora = now_time.minute - ((now_time.minute)%10);
          fila_actual = (((min_de_hora_ahora + min_ahora) - widget.day_ofset)/10).toInt();
          if(fila_actual == widget.index){destacar_fila = 0.2;}
          return Container(//height: 21,
            child: Card(color: widget.color_de_fondo, margin: EdgeInsets.only(top: 0.5, bottom: 0.5),
              child: Container(margin: EdgeInsets.only(right: 5, left: 5), color: Colors.grey.withOpacity(destacar_fila),
                child: desplegable(
                  color_de_fondo:  widget.color_de_fondo,
                  title: edit_acces && edit_acces_global ? editar_agenda(context) : ver_agenda(context),
                  body: Column(
                    children: [
                      Container(height: 20,
                        child: Row(
                          children: [
                            text_numero(color_day_now, !widget.num_u_hora),
                            Text("${widget.list_day[widget.index].substring(1)}", style: TextStyle(color: color_day_now,fontStyle: FontStyle.italic, fontSize: 15 ),),
                          ],
                        ),
                      ),
                      Container(height: 1, color: Colors.grey)
                    ],
                  ),),

              ),
            ),
          );
        }else {
          return Container();
        }
      },
    );
  }

  Widget editar_agenda(BuildContext context) {
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
    texcontrol_1.text = widget.list_day[widget.index].substring(1);
    text_edit_text = widget.list_day[widget.index].substring(1);
    guardado_timer();
                    //guardado_timer(now, seg, text_edit_text, myFocusNode);

    return Container(width: widget.w_pantalla , height: 20, child:  Container(
      child: Row(
        children: [
          text_numero (color_day_now, widget.num_u_hora),
          Container(width: widget.w_pantalla - 120,
            child: Transform.translate(offset: Offset(0, 1.5),child:
            TextField(
              focusNode: myFocusNode,
              controller: texcontrol_1,
              keyboardType: TextInputType.text,
              maxLines: 1,
              onSubmitted: (var a){
                //setState(() {focus = false;});
                setState(() {
                  widget.list_day[widget.index] = color_secret + text_edit_text;
                  edit_acces = false;
                  myFocusNode.dispose();
                });
                guardar_day (widget.list_day);
                agendaBloc.add(EnterEvent());
              },
              onChanged: (String val) {
                text_edit_text = val;
                widget.list_day[widget.index] = color_secret + text_edit_text;
                guardar_day (widget.list_day);
                guardado_timer();
                //setState(() { widget.list_day[widget.index] = color_secret + text_edit_text;});
                //guardado_timer(now, seg, text_edit_text, myFocusNode);
              },
              style: TextStyle(color: color_day_now,fontStyle: FontStyle.italic, fontSize: 15 ),),
            ),
          ),

          Container(width: 10,),

          Container(width: 20, height: 20, child: FlatButton(
            child: Icon(Icons.brightness_1, color: color_day_now, size: 20,),
            padding: EdgeInsets.all(0),
            onPressed: (){

              if (color_day_now == Colors.grey){
                color_secret = "1";
                color_day_now = Colors.indigo[300];
              }else if (color_day_now == Colors.indigo[300]){
                color_secret = "2";
                color_day_now = Colors.green;
              }else if (color_day_now == Colors.green){
                color_secret = "3";
                color_day_now = Colors.red[300];
              }else if (color_day_now == Colors.red[300]){
                color_secret = "0";//4
                color_day_now = Colors.purple[300];
              }else if (color_day_now == Colors.purple[300]){
                color_secret = "5";
                color_day_now = Colors.cyan[600];
              }else if (color_day_now == Colors.cyan[600]){
                color_secret = "6";
                color_day_now = Colors.orange[600];
              }else if (color_day_now == Colors.orange[600]){
                color_secret = "7";
                color_day_now = Colors.lime[700];
              }else if (color_day_now == Colors.lime[700]){
                color_secret = "8";
                color_day_now = Colors.brown[300];
              }else if (color_day_now == Colors.brown[300]){
                color_secret = "9";
                color_day_now = Colors.teal[400];
              }else if (color_day_now == Colors.teal[400]){
                color_secret = "0";
                color_day_now = Colors.grey;
              }
              widget.list_day[widget.index] = color_secret + widget.list_day[widget.index].substring(1);
              guardar_day (widget.list_day);
              agendaBloc.add(LoadAgendaEvent());
            },
          )),
          Container(width: 10,),
          Container(width: 20, height: 20, child: FlatButton(
            child: Icon(Icons.check_box, color: color_day_now, size: 20,),
            padding: EdgeInsets.all(0),
            onPressed: (){
              setState(() {
                widget.list_day[widget.index] = color_secret + text_edit_text;
                edit_acces =false;
                myFocusNode.dispose();
              });
              guardar_day (widget.list_day);
              agendaBloc.add(PalomearEvent());
              //Future.delayed(const Duration(milliseconds: 100), () { FocusScope.of(context).requestFocus( FocusNode()); });
            },
          ))
        ],
      ),
     ),);
  }

  void guardado_timer( ) {
    now = new DateTime.now();
    Future.delayed(Duration(seconds: seg), () {
      //setState(() {widget.list_day;});
      var now_futuro = new DateTime.now();
      if((now_futuro.microsecondsSinceEpoch - now.microsecondsSinceEpoch) > (seg * 1000000)){
        edit_acces = false;
        myFocusNode.dispose();
        agendaBloc.add(LoadAgendaEvent());
      }
    });
  }

  Widget ver_agenda(BuildContext context) {
    return Container(
      width: widget.w_pantalla,  child: Container(height: 20,
      child: Row(
        children: [
          text_numero(color_day_now, widget.num_u_hora),
          Container(width:(widget.w_pantalla -60),
            child: FlatButton(
              child: Row(
                children: [
                  Text("${widget.list_day[widget.index].substring(1)}", style: TextStyle(color: color_day_now,fontStyle: FontStyle.italic, fontSize: 15 ),),
                  Expanded(child: Container(), flex: 1,)
                ],
              ),
              padding: EdgeInsets.all(0),
              onPressed: (){
                setState(() {
                  setState(() {edit_acces_global = false;});
                  agendaBloc.add(LoadAgendaEvent());
                  Future.delayed(const Duration(milliseconds: 100), () {
                    setState(() {edit_acces = true;});
                    setState(() {edit_acces_global = true;});
                    agendaBloc.add(LoadAgendaEvent());
                  });
                });},
              onLongPress: (){
                Clipboard.setData(ClipboardData(text: widget.list_day[widget.index].substring(1)));
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("copied " + widget.list_day[widget.index].substring(1)),duration: Duration(seconds: 1),));
                setState(() {
                  /*
                  widget.list_day[widget.index] = "0";
                  widget.listItems[widget.index] = "0";
                  color_day_now = Colors.grey;
                  */
                });
                guardar_day(widget.list_day);
              },
            ),
          ),
          //Container(width: 20, height: 20, child: Icon(Icons.stop, color: color_day_now.withOpacity(0.8), size: 15,)),
        ],
      ),
    ),
);
  }

  Widget text_numero(Color color_text, bool num_info) {
    if(num_info){
      double zero_opasity = 0.7;
      if (((widget.index  + 1)%10) == 0){
        zero_opasity = 1.0;
      }
      return Container(width: 40,
        child: FlatButton(padding: EdgeInsets.all(0),
          child: Text("${widget.index  + 1} - ", style: TextStyle(color: color_text.withOpacity(zero_opasity),fontStyle: FontStyle.italic, fontSize: 15 ),),
          onPressed: (){setState(() {



          });},
        ),
      );
    }
    else{
      int min_day_list = (widget.index * 10)  + widget.day_ofset;//  (10  *  6  *  7);
      int siclo_hora = 0;
      int horas_day = 0;
      int min_day = 0;
      for(int i = 0; i < (min_day_list/10); i++){
        siclo_hora++;
        min_day++;
        if(siclo_hora == 6){
          siclo_hora = 0;
          horas_day++;
          min_day = 0;
        }
        if(horas_day == 24){
          siclo_hora = 0;
          horas_day = 0;
          min_day = 0;
        }
      }
      min_day = min_day * 10;
      String zero_extra = "";
      double zero_opasity = 0.7;
      if (siclo_hora == 0){
        zero_extra = "0";
        zero_opasity = 1.0;
      }
      return Container(width: 40,
        child: FlatButton(padding: EdgeInsets.all(0),
          child: Text( horas_day.toString() + ":" + min_day.toString() + zero_extra + "  ", style: TextStyle(color: color_text.withOpacity(zero_opasity),fontStyle: FontStyle.italic, fontSize: 14 ),),
          onPressed: (){setState(() {


          });},
        ),
      );
    }
  }
}
