
import 'dart:async';

import 'package:bloc/bloc.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  AgendaBloc() : super(InitialAgendaState());

  @override
  Stream<AgendaState> mapEventToState(
    AgendaEvent event,
  ) async* {
    if(event is LoadAgendaEvent){

      yield LoadAgendaState();
    }
  }
}
