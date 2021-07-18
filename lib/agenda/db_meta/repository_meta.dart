import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import 'modelo_meta.dart';


class MetaRepository {

  Future<void> salveMetas(Meta persona) async {

    print(persona.toString());
    Box hiveBox = await Hive.openBox('hive');
    await hiveBox.put('persona', persona);
  }

  Future<Meta> getHiveMetas()  async {
    Box hiveBox = await Hive.openBox('hive');
    Meta persistedPersona = hiveBox.get('persona');
    if (persistedPersona != null) {
      Meta persistedPersonaCopy = persistedPersona;
      return persistedPersonaCopy;
    }else{
      return null;
    }
  }
  
}
