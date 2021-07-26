

import 'package:hive/hive.dart';


part 'modelo_meta.g.dart';

@HiveType(typeId: 0)
class Meta extends HiveObject {

  Meta({this.titulo, this.descripcion, this.tag, this.minutos_estimados, this.metas});

  @HiveField(0)
  String titulo;

  @HiveField(1)
  String descripcion;

  @HiveField(2)
  int tag;

  @HiveField(3)
  int minutos_estimados;

  @HiveField(4)
  String fecha_de_inicio;

  @HiveField(5)
  String fecha_de_terminacion;

  @HiveField(6)
  List<Meta> metas;

  @HiveField(7)
  bool terminado;

  @HiveField(8)
  String repeticion;

  @HiveField(9)
  double porcentaje;

  @override
  String toString() {return '{titulo : $titulo, descripcion : $descripcion, metas : $metas}';}

  addSubMeta(Meta subMeta){
    if (metas == null || metas.isEmpty){
      metas = [subMeta];
    }else{
      metas.add(subMeta);
    }
  }

}
