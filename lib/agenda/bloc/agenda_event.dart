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

class EnterEvent extends AgendaEvent {
  const EnterEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EnterEvent';

}

class PalomearEvent extends AgendaEvent {
  const PalomearEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'PalomearEvent';

}

class TemaEvent extends AgendaEvent {
  const TemaEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'TemaEvent';

}
