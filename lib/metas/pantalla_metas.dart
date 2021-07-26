import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gus/db_meta/modelo_meta.dart';
import 'package:gus/desplegable.dart';
import 'package:gus/metas/rama.dart';

import 'bloc/meta_bloc.dart';

bool hay_meta_portapapeles = false;
bool accion_meta = false;
Meta meta_portapapeles = Meta();


class Pantalla_metas extends StatefulWidget {
  final double h_pantalla;
  final double w_pantalla;
  final Color color_de_fondo;
  const Pantalla_metas({Key key, this.color_de_fondo, this.h_pantalla, this.w_pantalla}) : super(key: key);

  @override
  _Pantalla_metasState createState() => _Pantalla_metasState();
}

class _Pantalla_metasState extends State<Pantalla_metas> {

  Meta subMeta = Meta(metas: [], minutos_estimados: 1, tag: 1, descripcion: "a", titulo: "b");
  MetaBloc metaBloc;


  @override
  void initState() {

    metaBloc = BlocProvider.of<MetaBloc>(context);
    metaBloc.add(GetMetaEvent());
  }

  @override
  Widget build(BuildContext context) {

    Widget botones = Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            color:widget.color_de_fondo,
            height: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  primary: widget.color_de_fondo,
                  side: BorderSide(color: Colors.grey)),
              child: Text(
                "accion 1",
                style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: 13),
              ),
              onPressed: () {

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
                "accion 2",
                style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: 13),
              ),
              onPressed: () {

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
                "accion 3",
                style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: 13),
              ),
              onPressed: () {
              },
            ),
          ),
          Container(
            width: 10,
            height: 1,
          ),
        ]);

    return Container(
      color: widget.color_de_fondo,
      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 10),
        child: Column(
          children: [
            desplegable(desplegado: false,
              body: Text("gus"),
              color_de_fondo: widget.color_de_fondo,
              title: Row(
                children: [
                  SizedBox(width: 10,),
                  Transform.translate(offset: Offset(0.0, 3.0),child:  Text("algo",style: TextStyle(color: Colors.grey),)),
                ],
              ),
            ),
            BlocBuilder<MetaBloc, MetaState>(
              builder: (context, state) {
                if(state is LoadMetaState){
                  return Column(
                    children: [
                      Container(height: widget.h_pantalla - 115,
                        child: ListView(
                          shrinkWrap: true,
                            children: <Widget>[ramificacion(
                              color_status: Colors.grey,
                              profundidad: 0,
                              color_de_fondo: widget.color_de_fondo,
                              onUpdate: (meta_de_regreso, info){
                                metaBloc.add(AddMetaEvent(newSubMeta: meta_de_regreso));
                              },
                              meta: state.meta,
                            )
                              ,]),
                      ),
                      //botones
                    ],
                  );
                }else{
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
