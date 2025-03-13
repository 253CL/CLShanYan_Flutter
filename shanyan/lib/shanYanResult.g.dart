// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shanYanResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShanYanResult _$ShanYanResultFromJson(Map<String, dynamic> json) =>
    ShanYanResult(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      innerCode: (json['innerCode'] as num?)?.toInt(),
      innerDesc: json['innerDesc'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ShanYanResultToJson(ShanYanResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'innerCode': instance.innerCode,
      'innerDesc': instance.innerDesc,
      'token': instance.token,
    };
