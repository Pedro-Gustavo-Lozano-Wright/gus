
part of 'meta_bloc.dart';

abstract class MetaState {
  const MetaState();
}

class InitialMetaState extends MetaState {
  @override
  List<Object> get props => [];
}

class LoadMetaState extends MetaState {
  final Meta meta;

  LoadMetaState({this.meta});

  @override
  List<Object> get props => [meta];

}
