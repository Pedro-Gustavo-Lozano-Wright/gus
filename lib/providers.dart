
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gus/db_meta/modelo_meta.dart';

import 'agenda/bloc/agenda_bloc.dart';
import 'db_meta/repository_meta.dart';
import 'metas/bloc/meta_bloc.dart';

final providersList = [
  BlocProvider<AgendaBloc>(
    create: (context) {
      return AgendaBloc(metaRepository: MetaRepository());}),
  BlocProvider<MetaBloc>(
    create: (context) {
      return MetaBloc(metaRepository: MetaRepository());}),
/*..add(AgendaEvent())*//*
;
    },
  ),

 BlocProvider<LoginBloc>(
    create: (context) {
      return LoginBloc(
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
        authenticationRepository: AuthenticationRepository(),
      );
    },
  ),*/
];
