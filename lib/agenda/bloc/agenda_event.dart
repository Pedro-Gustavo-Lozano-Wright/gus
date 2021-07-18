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

class salvePersonEvent extends AgendaEvent {

  final Meta meta;

  const salvePersonEvent({this.meta});

  @override
  List<Object> get props => [meta];

}

class getPersonEvent extends AgendaEvent {

  const getPersonEvent();

  @override
  List<Object> get props => [];

}

class addSubMetaEvent extends AgendaEvent {

  final Meta subMeta;

  const addSubMetaEvent({this.subMeta});

  @override
  List<Object> get props => [subMeta];

}
