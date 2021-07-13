

import 'package:hive/hive.dart';


part 'transaction.g.dart';

@HiveType(typeId: 0)
class Persona extends HiveObject {
  Persona({this.name, this.age});

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @override
  String toString() {
    return '$name: $age';
  }
}

Future<void> anadir_persona() async {
  Hive.registerAdapter(PersonaAdapter());
  /*final*/ var box = await Hive.openBox<Persona>("persona");
  Persona transaction = Persona(name: "gus", age: 25);
  box.add(transaction);
}


Future<void> adir_persona_por_key() async {
  Hive.registerAdapter(PersonaAdapter());
  /*final*/ var box = await Hive.openBox<Persona>("persona");
  Persona person = Persona(name: 'Dave', age: 22,);
  await box.put('dave', person);
}


Future<void> borrar_persona() async {
  Hive.registerAdapter(PersonaAdapter());
  /*final*/ var box = await Hive.openBox<Persona>("persona");
  box.delete('dave');
}
//box.delete('key) - borrar por key.
//box.deleteAt(index) - porrar por index segun se el orden de creacion.
//box.deleteAll(keys) - deletes all the keys given.


Future<void> leer_personas() async {
  List _inventoryList = <Persona>[];
  Hive.registerAdapter(PersonaAdapter());
  /*final*/ var box = await Hive.openBox<Persona>("persona");
  _inventoryList = box.values.toList();
  print("_inventoryList");
  print(_inventoryList);
}

Future<void> leer_una_persona() async {
  Hive.registerAdapter(PersonaAdapter());
  /*final*/ var box = await Hive.openBox<Persona>("persona");
  print("box.get('dave')");
  print(box.get('dave'));
}
//box.get('key) - get the value from a key.
//box.getAt(index) - get the value from an index created with box.add().
//box.values - this returns an iterable containing all the items in the box.
