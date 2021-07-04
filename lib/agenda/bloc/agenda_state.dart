
part of 'agenda_bloc.dart';

abstract class AgendaState {
  const AgendaState();
}

class InitialAgendaState extends AgendaState {
  @override
  List<Object> get props => [];
}

class LoadAgendaState extends AgendaState {
  @override
  List<Object> get props => [];
}
