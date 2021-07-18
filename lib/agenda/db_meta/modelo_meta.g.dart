// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelo_meta.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MetaAdapter extends TypeAdapter<Meta> {
  @override
  final int typeId = 0;

  @override
  Meta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meta(
      titulo: fields[0] as String,
      descripcion: fields[1] as String,
      id: fields[2] as int,
    )..metas = (fields[3] as List)?.cast<Meta>();
  }

  @override
  void write(BinaryWriter writer, Meta obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.titulo)
      ..writeByte(1)
      ..write(obj.descripcion)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.metas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
