import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gus/db_meta/modelo_meta.dart';

import '../desplegable.dart';
import 'bloc/meta_bloc.dart';
import 'pantalla_metas.dart';

class ramificacion extends StatefulWidget {
  final Color color_status;
  final Color color_de_fondo;
  final int profundidad;
  final Meta meta;
  final Function(Meta, String) onUpdate;

  const ramificacion({Key key, this.onUpdate, this.meta, this.color_de_fondo, this.profundidad, this.color_status}) : super(key: key);

  @override
  _ramificacionState createState() => _ramificacionState();
}

class _ramificacionState extends State<ramificacion> {

  MetaBloc metaBloc;
  bool seguro_borrar = false;
  bool seguro_cortar = false;
  bool menu_1 = false;
  bool menu_2 = false;
  int menu_estado = 0;


  Meta hiveMeta = Meta(titulo: "exito", descripcion: "Alcanzar metas", minutos_estimados: 10, tag: 13, metas: []);

  @override
  void initState() {
    metaBloc = BlocProvider.of<MetaBloc>(context);

   /* if(accion_meta){
      if (meta_portapapeles == widget.meta){
        setState(() {
          menu_1 = true;
        });
        accion_meta = false;
        meta_portapapeles = Meta();
      }
    }{
      setState(() {
        menu_1 = false;
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {

    Future PestanaEmergenteCompacta(BuildContext context) {
      TextEditingController texcontrol_1 = TextEditingController();
      texcontrol_1.text = widget.meta.descripcion;
      return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(side: BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0),),),
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AnimatedPadding(
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOut,
              padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(color: Colors.black,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              widget.meta.titulo,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "descripcion",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ), Container(height: 60,
                            child: TextField(
                              controller: texcontrol_1,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              onSubmitted: (var a){
                                widget.meta.descripcion = a;
                                widget.onUpdate(widget.meta,"");
                              },
                              style: TextStyle(color: Colors.grey,fontStyle: FontStyle.italic, fontSize: 15 ),),
                           ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    TextEditingController texcontrol = TextEditingController();
    texcontrol.text = widget.meta.titulo;//profundidad.toString();//Container(width: 10,child: IconButton(onPressed: (){}, icon: Icon(Icons.circle, size: 10,color: Colors.indigo,))),
    Widget header = Container(
      child: Row(
        children: [
          Container(padding: EdgeInsets.only(right: 3,bottom: 3),
              width: 10,child: Icon(Icons.circle, size: 5,color: seguro_borrar || seguro_cortar ? Colors.red : menu_1 || menu_2 ? Colors.blue : widget.profundidad > 10 ? Colors.deepOrangeAccent : widget.color_status,)),
          Container(
            width: menu_1 && menu_2 ?
            MediaQuery.of(context).size.width - (widget.profundidad * 10) - 65  - 160 :
            menu_1 || menu_2 ?
            MediaQuery.of(context).size.width - (widget.profundidad * 10) - 65  - 80 :
            MediaQuery.of(context).size.width - (widget.profundidad * 10) - 65  - 0 ,
            height: 20,child: TextField(
            controller: texcontrol,
            keyboardType: TextInputType.text,
            maxLines: 1,
            onSubmitted: (String text){
              widget.meta.titulo = text;
              widget.onUpdate(widget.meta,"");
            },
            onChanged: (String val) {
              //widget.meta.titulo = val;
              //widget.onUpdate(widget.meta,"");
              //setState(() {texcontrol.text = val;});
            },
            style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 15 ),),
          ),
          Row(
            children: [
              Container(width: menu_2 ? 80 : 0,
                child: Row(
                  children: [
                    Container(height: 20, width: 20,
                      child: TextButton(
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
                          onPressed: (){
                            if(hay_meta_portapapeles){
                              widget.meta.metas.length == 0 || widget.meta.metas.isEmpty? widget.meta.metas = [meta_portapapeles] : widget.meta.metas = ([meta_portapapeles] + widget.meta.metas) ;
                              widget.onUpdate(widget.meta, "");
                              meta_portapapeles = Meta();
                              hay_meta_portapapeles = false;
                            }
                          }, child: Center(child: Icon(Icons.paste, size: 15,color: hay_meta_portapapeles ? Colors.grey : Colors.grey.withOpacity(0.5) ))),
                    ),
                    Container(height: 20, width: 20,
                      child: TextButton(
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
                          onPressed: (){
                            meta_portapapeles = widget.meta;
                            hay_meta_portapapeles = true;
                            widget.onUpdate(widget.meta, "");
                          }, child: Center(child: Icon(Icons.copy, size: 13,color: Colors.grey))),
                    ),
                    Container(height: 20, width: 20,
                      child: TextButton(
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
                          onPressed: (){
                            if (seguro_cortar){
                              seguro_cortar = false;
                              meta_portapapeles = widget.meta;
                              hay_meta_portapapeles = true;
                              widget.onUpdate(widget.meta,"delete");
                            }else{
                              setState(() {seguro_cortar = true;});
                            }
                          }, child: Center(child: Icon(Icons.cut, size: 14,color: seguro_cortar ? Colors.red : Colors.grey))),
                    ),
                    Container(height: 20, width: 20,
                      child: TextButton(
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
                          onPressed: (){
                            if (seguro_borrar){
                              setState(() {seguro_borrar = false;});
                              widget.onUpdate(widget.meta,"delete");
                            }else{
                              setState(() {seguro_borrar = true;});
                            }
                          }, child: Center(child: Icon(Icons.delete_outline, size: 15,color: seguro_borrar ? Colors.red : Colors.grey))),
                    ),
                  ],
                ),
              ),
              Container(
                width: menu_1 ? 80 : 0,// height: 20, color: Colors.red,
                child: Row(
                  children: [
                    Container(height: 20, width: 20,
                      child: TextButton(
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
                          onPressed: (){
                            PestanaEmergenteCompacta(context);
                          }, child: Center(child: Icon(Icons.format_list_bulleted_rounded, size: 15, color: Colors.grey))),
                    ),
                    Container(height: 20, width: 20,
                      child: TextButton(
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
                          onPressed: (){
                            widget.onUpdate(widget.meta,"up");
                          }, child: Center(child: Icon(Icons.arrow_drop_up, size: 20, color: Colors.grey))),
                    ),
                    Container(height: 20, width: 20,
                      child: TextButton(
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
                          onPressed: (){
                            widget.onUpdate(widget.meta,"down");
                          }, child: Center(child: Icon(Icons.arrow_drop_down, size: 20, color:  Colors.grey))),
                    ),
                    Container(height: 20, width: 20,
                      child: TextButton(
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
                          onPressed: (){
                            if(widget.meta.metas == null || widget.meta.metas.isEmpty || widget.meta.metas.length == 0 ){
                              widget.meta.metas = [Meta(titulo: "", descripcion: "new meta", minutos_estimados: 10, tag: 13, metas: [])];
                              widget.onUpdate(widget.meta, "");
                            }else{
                              List<Meta> new_meta = [Meta(titulo: "", descripcion: "new meta", minutos_estimados: 10, tag: 13, metas: [])];
                              widget.meta.metas = new_meta + widget.meta.metas ;
                              widget.onUpdate(widget.meta, "");
                            }
                          }, child: Center(child: Icon(Icons.add, size: 15,color: Colors.grey,))),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(height: 20, width: 20,
                    child: TextButton(
                        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
                        onLongPress: (){
                          if (menu_2){
                            setState(() {
                              menu_2 = false;
                            });
                          }else{
                            setState(() {});
                          }
                        },
                        onPressed: (){

                          setState(() {
                            if(menu_estado == 0){
                              menu_estado = 1;
                              menu_1 = true;
                            } else if(menu_estado == 1) {
                              menu_estado = 2;
                              menu_1 = false;
                              menu_2 = true;
                            } else if(menu_estado == 2) {
                              menu_estado = 0;
                              menu_2 = false;
                              seguro_borrar = false;
                              seguro_cortar = false;
                            }
                          });

                        }, child: Center(child: Icon(menu_1 || menu_2 ? Icons.arrow_left : Icons.arrow_right, size: 20,color: Colors.grey))),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );

    if (widget.meta.metas == null || widget.meta.metas.isEmpty || widget.meta.metas.length == 0 ) {

      return header;

    } else {

      List<Widget> ramas = [];

      for(int i = 0 ; i < widget.meta.metas.length ; i ++){
        ramas.add(
          Container(
            child: ramificacion(
              color_status: seguro_borrar || seguro_cortar ? Colors.red : menu_1 || menu_2 ? Colors.blue : widget.color_status,
              profundidad: widget.profundidad + 1,
              meta: widget.meta.metas[i],
              onUpdate: (meta_de_regreso, info){
                if(info == ""){
                  widget.meta.metas[i] = meta_de_regreso;
                  widget.onUpdate(widget.meta,"");
                } else if(info == "delete"){
                  widget.meta.metas.remove(meta_de_regreso);
                  widget.onUpdate(widget.meta,"");
                } else if(info == "up"){
                  if(0 != i ){
                    accion_meta = true;
                    meta_portapapeles = widget.meta;
                    if( 1 == i ){
                      widget.meta.descripcion = "=" + widget.meta.descripcion;
                      widget.meta.metas.remove(meta_de_regreso);
                      widget.meta.metas.insert(0, meta_de_regreso);
                      widget.onUpdate(widget.meta,"");
                    }else{
                      widget.meta.descripcion = "=" + widget.meta.descripcion;
                      widget.meta.metas.remove(meta_de_regreso);
                      widget.meta.metas.insert(i - 1, meta_de_regreso);
                      widget.onUpdate(widget.meta,"");
                    }

                  }
                } else if(info == "down"){
                  if(widget.meta.metas.length != i){
                    accion_meta = true;
                    meta_portapapeles = widget.meta;
                    widget.meta.metas.remove(meta_de_regreso);
                    widget.meta.metas.insert(i + 1, meta_de_regreso);
                    widget.onUpdate(widget.meta,"");
                  }
                }
              },
              color_de_fondo: widget.color_de_fondo,
            ),
          ),
        );
      }
      Widget arbol = Container(
        alignment: Alignment.topLeft,
        child: desplegable(desplegado: true,
          title: header,
          body: Container(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: ramas
            ),
          ),
        ),
      );
      return arbol;
    }
    //return Container(color: Colors.white ,child: Center(child: Text("data")));
  }
}



