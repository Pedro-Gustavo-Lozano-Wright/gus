import 'package:gus/db_meta/modelo_meta.dart';
import 'package:hive/hive.dart';

//import '../models/Day/day.dart';
//import '../models/Food/food.dart';

void registerHiveAdapter() {
  Hive.registerAdapter(MetaAdapter());
  //Hive.registerAdapter(ItemAgendaAdapter());
  //Hive.registerAdapter(DayAdapter());
  //Hive.registerAdapter(FoodAdapter());
}