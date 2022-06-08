// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String id;
  final String idproduct;
  final String nameproduct;
  final String typeproduct;
  final String priceproduct;
  final String productdetail;
  final String Images;
  ProductModel({
    required this.id,
    required this.idproduct,
    required this.nameproduct,
    required this.typeproduct,
    required this.priceproduct,
    required this.productdetail,
    required this.Images,
  });

  ProductModel copyWith({
    String? id,
    String? idproduct,
    String? nameproduct,
    String? typeproduct,
    String? priceproduct,
    String? productdetail,
    String? Images,
  }) {
    return ProductModel(
      id: id ?? this.id,
      idproduct: idproduct ?? this.idproduct,
      nameproduct: nameproduct ?? this.nameproduct,
      typeproduct: typeproduct ?? this.typeproduct,
      priceproduct: priceproduct ?? this.priceproduct,
      productdetail: productdetail ?? this.productdetail,
      Images: Images ?? this.Images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idproduct': idproduct,
      'nameproduct': nameproduct,
      'typeproduct': typeproduct,
      'priceproduct': priceproduct,
      'productdetail': productdetail,
      'Images': Images,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      idproduct: map['idproduct'] as String,
      nameproduct: map['nameproduct'] as String,
      typeproduct: map['typeproduct'] as String,
      priceproduct: map['priceproduct'] as String,
      productdetail: map['productdetail'] as String,
      Images: map['Images'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, idproduct: $idproduct, nameproduct: $nameproduct, typeproduct: $typeproduct, priceproduct: $priceproduct, productdetail: $productdetail, Images: $Images)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductModel &&
      other.id == id &&
      other.idproduct == idproduct &&
      other.nameproduct == nameproduct &&
      other.typeproduct == typeproduct &&
      other.priceproduct == priceproduct &&
      other.productdetail == productdetail &&
      other.Images == Images;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      idproduct.hashCode ^
      nameproduct.hashCode ^
      typeproduct.hashCode ^
      priceproduct.hashCode ^
      productdetail.hashCode ^
      Images.hashCode;
  }
}
