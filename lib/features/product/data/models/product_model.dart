import 'package:json_annotation/json_annotation.dart';
import 'package:palm365_test/core/converters/date_time_converter.dart';
import 'package:palm365_test/features/product/domain/entities/product_entity.dart';
part 'product_model.g.dart';

@JsonSerializable()
@DateTimeConverter()
class ProductModel extends ProductEntity {
  final int? id;
  final int? amount;
  final int? groupId;
  final String? name;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? price;
  final String? description;
  const ProductModel({
    this.id,
    this.name,
    this.price,
    this.imageUrl,
    this.description,
    this.groupId,
    this.amount,
    this.createdAt,
    this.updatedAt,
  }) : super(
          id: id,
          amount: amount,
          description: description,
          price: price,
          name: name,
          imageUrl: imageUrl,
          groupId: groupId,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
  static ProductModel fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      amount: entity.amount,
      description: entity.description,
      price: entity.price,
      name: entity.name,
      imageUrl: entity.imageUrl,
      groupId: entity.groupId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
 