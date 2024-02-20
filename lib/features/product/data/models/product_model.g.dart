// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      groupId: json['groupId'] as int?,
      amount: json['amount'] as int?,
      createdAt: _$JsonConverterFromJson<int, DateTime>(
          json['createdAt'], const DateTimeConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<int, DateTime>(
          json['updatedAt'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'groupId': instance.groupId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'createdAt': _$JsonConverterToJson<int, DateTime>(
          instance.createdAt, const DateTimeConverter().toJson),
      'updatedAt': _$JsonConverterToJson<int, DateTime>(
          instance.updatedAt, const DateTimeConverter().toJson),
      'price': instance.price,
      'description': instance.description,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
