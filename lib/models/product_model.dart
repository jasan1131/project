// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String id;
  final String idproduct;
  final String nameproduct;
  final String typeproduct;
  final String numberproduct;
  final String priceproduct;
  final String detailproduct;
  final String imagesproduct;
  ProductModel({
    required this.id,
    required this.idproduct,
    required this.nameproduct,
    required this.typeproduct,
    required this.numberproduct,
    required this.priceproduct,
    required this.detailproduct,
    required this.imagesproduct,
  });

  ProductModel copyWith({
    String? id,
    String? idproduct,
    String? nameproduct,
    String? typeproduct,
    String? numberproduct,
    String? priceproduct,
    String? detailproduct,
    String? imagesproduct,
  }) {
    return ProductModel(
      id: id ?? this.id,
      idproduct: idproduct ?? this.idproduct,
      nameproduct: nameproduct ?? this.nameproduct,
      typeproduct: typeproduct ?? this.typeproduct,
      numberproduct: numberproduct ?? this.numberproduct,
      priceproduct: priceproduct ?? this.priceproduct,
      detailproduct: detailproduct ?? this.detailproduct,
      imagesproduct: imagesproduct ?? this.imagesproduct,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idproduct': idproduct,
      'nameproduct': nameproduct,
      'typeproduct': typeproduct,
      'numberproduct': numberproduct,
      'priceproduct': priceproduct,
      'detailproduct': detailproduct,
      'imagesproduct': imagesproduct,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      idproduct: map['idproduct'] as String,
      nameproduct: map['nameproduct'] as String,
      typeproduct: map['typeproduct'] as String,
      numberproduct: map['numberproduct'] as String,
      priceproduct: map['priceproduct'] as String,
      detailproduct: map['detailproduct'] as String,
      imagesproduct: map['imagesproduct'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, idproduct: $idproduct, nameproduct: $nameproduct, typeproduct: $typeproduct, numberproduct: $numberproduct, priceproduct: $priceproduct, detailproduct: $detailproduct, imagesproduct: $imagesproduct)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductModel &&
      other.id == id &&
      other.idproduct == idproduct &&
      other.nameproduct == nameproduct &&
      other.typeproduct == typeproduct &&
      other.numberproduct == numberproduct &&
      other.priceproduct == priceproduct &&
      other.detailproduct == detailproduct &&
      other.imagesproduct == imagesproduct;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      idproduct.hashCode ^
      nameproduct.hashCode ^
      typeproduct.hashCode ^
      numberproduct.hashCode ^
      priceproduct.hashCode ^
      detailproduct.hashCode ^
      imagesproduct.hashCode;
  }
}
