
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gus/db_meta/modelo_meta.dart';
import 'package:gus/db_meta/repository_meta.dart';
import 'package:hive/hive.dart';

part 'meta_event.dart';
part 'meta_state.dart';

class MetaBloc extends Bloc<MetaEvent, MetaState> {

  final MetaRepository metaRepository;

  MetaBloc({this.metaRepository}) : super(InitialMetaState());

  Meta hiveMeta = Meta(titulo: "exito", descripcion: "Alcanzar metas", minutos_estimados: 10, tag: 13, metas: []);
  
  @override
  Stream<MetaState> mapEventToState (MetaEvent event,) async* {
    if(event is LoadMetaEvent){
      yield LoadMetaState(meta: hiveMeta);
    }
    if(event is EnterEvent){
      yield LoadMetaState(meta: hiveMeta);
    }
    if(event is PalomearEvent){
      yield LoadMetaState(meta: hiveMeta);
    }
    if(event is TemaEvent){
      yield LoadMetaState(meta: hiveMeta);
    }
    if(event is UpdateMetaEvent){
      hiveMeta = event.updateMeta;
      metaRepository.salveMetas(hiveMeta);
      yield LoadMetaState(meta: hiveMeta);
    }
    if(event is AddMetaEvent){
      metaRepository.salveMetas(event.newSubMeta);
      yield LoadMetaState(meta: hiveMeta);
    }
    if(event is GetMetaEvent){
      hiveMeta = await metaRepository.getHiveMetas();
      print(hiveMeta.toString());
      yield LoadMetaState(meta: hiveMeta);
    }
    if(event is addSubMetaEvent){
      hiveMeta.addSubMeta(event.subMeta);
      metaRepository.salveMetas(hiveMeta);
      yield LoadMetaState(meta: hiveMeta);
    }
  }
}
