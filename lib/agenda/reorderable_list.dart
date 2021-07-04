import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gus/agenda/shared_preferences.dart';
import 'package:gus/agenda/variables_globales.dart';

class ListViewCard extends StatefulWidget {
  final int index;
  final Key key;
  final List<String> listItems;

  ListViewCard(this.listItems, this.index, this.key);

  @override
  _ListViewCard createState() => _ListViewCard();
}

class _ListViewCard extends State<ListViewCard> {


  int index_edicion_actual = 0;

  Color color_day_now = Colors.grey;

  double text_width = 0.0;

  int fila_actual;

  double destacar_fila = 0.0;

  String color_secret = "0";

  @override
  void initState() {

    text_width = w_pantalla;

    try{
      color_secret = widget.listItems[widget.index].substring(0,1);
    }catch(Exception){
      print("fallo");
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
    }
    else if (color_secret == "0"){
      color_day_now = Colors.grey;
    }else {
      color_day_now = Colors.grey;
    }

    var now_time = DateTime.now();
    int min_de_hora_ahora = now_time.hour * 60;
    int min_ahora = now_time.minute - ((now_time.minute)%10);
    fila_actual = (((min_de_hora_ahora + min_ahora) - day_ofset)/10).toInt();// - ( * 10);
    if(fila_actual == widget.index){/*color_day_now = color_de_fondo_contraste;*/destacar_fila = 0.2;}
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: 21,
      child: Card(color: color_de_fondo, margin: EdgeInsets.only(top: 0.5, bottom: 0.5),
        child: Container(margin: EdgeInsets.only(right: 5, left: 5), color: color_principal.withOpacity(destacar_fila),
          child: Row(
            children: [
              Container(
                  width: text_width, height: 20, child: Row(
                children: [
                  text_numero (color_day_now),
                  Container(width: (text_width -60),
                    child: FlatButton(
                      child: Row(
                        children: [
                          Text("${widget.listItems[widget.index].substring(1)}", style: TextStyle(color: color_day_now,fontStyle: FontStyle.italic, fontSize: 15 ),),
                          Expanded(child: Container(), flex: 1,)
                        ],
                      ),
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        setState(() {
                          if(acceso_a_edit_text){
                            texcontrol_1.text = widget.listItems[widget.index].substring(1);
                            text_edit_text = widget.listItems[widget.index].substring(1);
                            index_edicion_actual = widget.index;
                            acceso_a_edit_text = false;
                            setState(() {
                              text_width = 0.0;
                            });
                          }
                        });},
                      onLongPress: (){
                        Clipboard.setData(ClipboardData(text: widget.listItems[widget.index].substring(1)));
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text("copied " + widget.listItems[widget.index].substring(1)),duration: Duration(seconds: 1),));
                        setState(() {
                          list_day[widget.index] = "0";
                          widget.listItems[widget.index] = "0";
                          color_day_now = Colors.grey;
                          //text_width = width_pantalla;
                        });
                        guardar_day();
                      },
                    ),
                  ),

                  Container(width: 20, height: 20, child: Icon(Icons.stop, color: color_day_now.withOpacity(0.8), size: 15,))
                ],
              )),

              Container(width: w_pantalla - text_width, height: 20, child:  Container(
                child: Row(
                  children: [
                    text_numero (color_day_now),
                    //Container(width: 40, child: Text("${widget.index + 1} - ", style: TextStyle(color: color_principal.withOpacity(0.8),fontStyle: FontStyle.italic, fontSize: 15 ),)),
                    Container(width: w_pantalla -100,
                      child: Transform.translate(offset: Offset(0, 1.5),child: TextField(controller: texcontrol_1, keyboardType: TextInputType.text , maxLines: 1,// keyboardTipe: TextInputTipe.
                        onChanged: (String val) {

                          text_edit_text = val;
                          index_edicion_actual = widget.index;
                        },onEditingComplete: (){
                          acceso_a_edit_text = true;
                          setState(() {
                            list_day[index_edicion_actual] = color_secret + text_edit_text;
                            widget.listItems[widget.index] = color_secret + text_edit_text;
                            text_width = w_pantalla;
                          });
                          guardar_day ();
                          Future.delayed(const Duration(milliseconds: 100), () { FocusScope.of(context).requestFocus( FocusNode()); });
                        },
                        style: TextStyle(color: color_day_now,fontStyle: FontStyle.italic, fontSize: 15 ),),
                      ),
                    ),

                    Container(width: 10,),

                    Container(width: 20, height: 20, child: FlatButton(
                      child: Icon(Icons.brightness_1, color: color_day_now, size: 20,),
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        setState(() {
                          set_color();
                        });
                        Future.delayed(const Duration(milliseconds: 100), () { FocusScope.of(context).requestFocus( FocusNode()); });

                      },
                    )),

                    Container(width: 10,),
                    Container(width: 20, height: 20, child: FlatButton(
                      child: Icon(Icons.check_box, color: color_day_now, size: 20,),
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        acceso_a_edit_text = true;
                        setState(() {
                          list_day[index_edicion_actual] = color_secret + text_edit_text;
                          widget.listItems[widget.index] = color_secret + text_edit_text;
                          text_width = w_pantalla;
                        });
                        guardar_day ();
                        Future.delayed(const Duration(milliseconds: 100), () { FocusScope.of(context).requestFocus( FocusNode()); });

                      },
                    ))
                  ],
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }

  void set_color() {
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
  }


  Widget text_numero (Color color_text) {

    if(num_u_hora){

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
      int min_day_list = (widget.index * 10)  + day_ofset;//  (10  *  6  *  7);
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
