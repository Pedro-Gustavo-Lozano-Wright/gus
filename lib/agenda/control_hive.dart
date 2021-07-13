/*
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'modelo_persona/presistencia.dart';

void persistencia() async {
  var path = Directory.current.path;
  Hive
    ..init(path);
  //..registerAdapter(PersonAdapter());

  var box = await Hive.openBox('testBox');

  var person = Person(
    name: 'Dave',
    age: 22,
    friends: ['Linda', 'Marc', 'Anne'],
  );

  await box.put('dave', person);

  print(box.get('dave')); // Dave: 22
}

//flutter packages pub run build_runner build*/
