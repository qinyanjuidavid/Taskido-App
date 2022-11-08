// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_check_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenCheckAdapter extends TypeAdapter<TokenCheck> {
  @override
  final int typeId = 4;

  @override
  TokenCheck read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TokenCheck(
      otpData: fields[0] as OtpData?,
      message: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TokenCheck obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.otpData)
      ..writeByte(1)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenCheckAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OtpDataAdapter extends TypeAdapter<OtpData> {
  @override
  final int typeId = 5;

  @override
  OtpData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OtpData(
      token: fields[0] as String?,
      phone: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OtpData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OtpDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
