
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gus/agenda/db_meta/modelo_meta.dart';
import 'package:gus/agenda/db_meta/repository_meta.dart';
import 'package:hive/hive.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {

  final MetaRepository metaRepository;

  AgendaBloc({this.metaRepository}) : super(InitialAgendaState());

  Meta hiveMeta;
  
  @override
  Stream<AgendaState> mapEventToState (AgendaEvent event,) async* {
    if(event is LoadAgendaEvent){
      yield LoadAgendaState();
    }
    if(event is EnterEvent){
      yield LoadAgendaState();
    }
    if(event is PalomearEvent){
      yield LoadAgendaState();
    }
    if(event is TemaEvent){
      yield LoadAgendaState();
    }
    if(event is salvePersonEvent){
      metaRepository.salveMetas(event.meta);
    }
    if(event is getPersonEvent){
      hiveMeta = await metaRepository.getHiveMetas();
      print(hiveMeta.toString());
    }
    if(event is addSubMetaEvent){
      hiveMeta.addSubMeta(event.subMeta);
      metaRepository.salveMetas(hiveMeta);
    }
  }
}
