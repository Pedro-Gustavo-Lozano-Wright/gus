

import 'package:hive/hive.dart';


part 'modelo_meta.g.dart';

@HiveType(typeId: 0)
class Meta extends HiveObject {

  Meta({this.titulo, this.descripcion, this.id });

  @HiveField(0)
  String titulo;

  @HiveField(1)
  String descripcion;

  @HiveField(2)
  int id;

  @HiveField(3)
  List<Meta> metas;

  @override
  String toString() {return '{titulo : $titulo, descripcion : $descripcion, id : $id, metas : $metas}';}

  addSubMeta(Meta subMeta){
    if (metas == null || metas.isEmpty){
      metas = [subMeta];
    }else{
      metas.add(subMeta);
    }
  }

}
