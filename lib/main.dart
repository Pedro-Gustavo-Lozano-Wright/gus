import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gus/agenda/pantalla_dia.dart';
import 'package:gus/providers.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pantallas_de_navegacion.dart';
import 'hive_adapters.dart';

/*Future<void> main()  {
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  runApp( MultiBlocProvider(
    providers: [...providersList],
    child: MyApp(),
  ),);

}*/
/*
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp( MultiBlocProvider(
    providers: [...providersList],
    child: MyApp(),
  ),);
}*/


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  registerHiveAdapter();

  runApp( MultiBlocProvider(
    providers: [...providersList],
    child: MyApp(),
  ),);

}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Color color_de_fondo = Colors.black;
    return Scaffold(body: pantalla_de_navegacion(color_de_fondo: color_de_fondo,));
  }
}
