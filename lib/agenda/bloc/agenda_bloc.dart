
import 'dart:async';

import 'package:bloc/bloc.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  AgendaBloc() : super(InitialAgendaState());

  int tema = 0;

  @override
  Stream<AgendaState> mapEventToState(
    AgendaEvent event,
  ) async* {
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
  }
}
