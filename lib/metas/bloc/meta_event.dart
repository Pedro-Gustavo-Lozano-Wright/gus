part of 'meta_bloc.dart';

abstract class MetaEvent  {
  const MetaEvent();
}

class LoadMetaEvent extends MetaEvent {
  const LoadMetaEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoadMetaEvent';

}

class EnterEvent extends MetaEvent {
  const EnterEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EnterEvent';

}

class PalomearEvent extends MetaEvent {
  const PalomearEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'PalomearEvent';

}

class TemaEvent extends MetaEvent {
  const TemaEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'TemaEvent';

}

class AddMetaEvent extends MetaEvent {

  final Meta newSubMeta;

  const AddMetaEvent({this.newSubMeta});

  @override
  List<Object> get props => [newSubMeta];

}

class GetMetaEvent extends MetaEvent {

  const GetMetaEvent();

  @override
  List<Object> get props => [];

}

class addSubMetaEvent extends MetaEvent {

  final Meta subMeta;

  const addSubMetaEvent({this.subMeta});

  @override
  List<Object> get props => [subMeta];

}

class UpdateMetaEvent extends MetaEvent {

  final Meta updateMeta;

  const UpdateMetaEvent({this.updateMeta});

  @override
  List<Object> get props => [updateMeta];

}
