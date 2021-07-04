part of 'agenda_bloc.dart';

abstract class AgendaEvent  {
  const AgendaEvent();
}

class LoadAgendaEvent extends AgendaEvent {
  const LoadAgendaEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoadAgendaEvent';

}
