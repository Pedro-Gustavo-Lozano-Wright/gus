
import 'package:gus/agenda/variables_globales.dart';
import 'package:shared_preferences/shared_preferences.dart';

void guardar_preference_day_hoy(String _preferencia_day_hoy) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('preferencia_day_0', _preferencia_day_hoy);
}

String lista_100 =
    "0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*" +
        "0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*" +
        "0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*" +
        "0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*" +
        "0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0";


/*

Future<String> leer_preference_day_hoy() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return (prefs.getString('preferencia_day_0') ?? lista_100);
}




void guardar_preference_day_ofset(int _preferencia_day_ofset) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('preferencia_day_ofset', _preferencia_day_ofset);
}

Future<int> leer_preference_day_ofset() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return (prefs.getInt('preferencia_day_ofset') ?? 0);

}

void guardar_preference_num_u_hora(bool num_u_hora) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('preferencia_num_u_hora', num_u_hora);
}
*/
/*
Future<bool> leer_preference_num_u_hora() async {
  return await preference_num_u_hora();
}*//*


Future<bool> leer_preference_num_u_hora() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return (prefs.getBool('preferencia_num_u_hora') ?? true);
}

*/


void guardar_day (List<String> list_day){
  String stri_day_full = "";
  for (int i = 0; i < list_day.length; ++i) {
    if(i == 0){stri_day_full = list_day[i];}
    else{stri_day_full = stri_day_full + "*" + list_day[i];}
  }
  guardar_preference_day_hoy(stri_day_full);
}

Future<List<String>> leer_preference_day_hoy() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String preferencia_actual = (prefs.getString('preferencia_day_0') ?? lista_100);
  return preferencia_actual.split("*");
}

void guardar_preference_day_ofset(int _preferencia_day_ofset) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('preferencia_day_ofset', _preferencia_day_ofset);
}

Future<int> leer_preference_day_ofset() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return (prefs.getInt('preferencia_day_ofset') ?? 0);
}

void guardar_preference_num_u_hora(bool num_u_hora) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('preferencia_num_u_hora', num_u_hora);
}

 Future<bool> leer_preference_num_u_hora() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return (prefs.getBool('preferencia_num_u_hora') ?? true);
}