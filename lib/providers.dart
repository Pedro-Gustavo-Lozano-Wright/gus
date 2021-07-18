
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gus/agenda/db_meta/modelo_meta.dart';

import 'agenda/bloc/agenda_bloc.dart';
import 'agenda/db_meta/repository_meta.dart';

final providersList = [
  BlocProvider<AgendaBloc>(
    create: (context) {
      return AgendaBloc(metaRepository: MetaRepository());})
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
