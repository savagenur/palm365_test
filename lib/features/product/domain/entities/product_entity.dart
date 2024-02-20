import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int? id;
  final int? amount;
  final int? groupId;
  final String? name;
  final String? imageUrl;
  final int? price;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const ProductEntity({
    this.id,
    this.name,
    this.groupId,
    this.price,
    this.imageUrl,
    this.description,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });
  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        groupId,
        price,
        description,
        amount,
        createdAt,
        updatedAt,
      ];

  ProductEntity copyWith({
    int? id,
    int? amount,
    int? groupId,
    String? name,
    String? imageUrl,
    int? price,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
