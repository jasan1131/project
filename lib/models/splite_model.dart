// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SQLiteModel {
  final int? id;
  final String idProduct;
  final String nameProduct;
  final String priceProduct;
  final String amount;
  final String sum;
  SQLiteModel({
    this.id,
    required this.idProduct,
    required this.nameProduct,
    required this.priceProduct,
    required this.amount,
    required this.sum,
  });

  SQLiteModel copyWith({
    int? id,
    String? idProduct,
    String? nameProduct,
    String? priceProduct,
    String? amount,
    String? sum,
  }) {
    return SQLiteModel(
      id: id ?? this.id,
      idProduct: idProduct ?? this.idProduct,
      nameProduct: nameProduct ?? this.nameProduct,
      priceProduct: priceProduct ?? this.priceProduct,
      amount: amount ?? this.amount,
      sum: sum ?? this.sum,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idProduct': idProduct,
      'nameProduct': nameProduct,
      'priceProduct': priceProduct,
      'amount': amount,
      'sum': sum,
    };
  }

  factory SQLiteModel.fromMap(Map<String, dynamic> map) {
    return SQLiteModel(
      id: map['id'] != null ? map['id'] as int : null,
      idProduct: map['idProduct'] as String,
      nameProduct: map['nameProduct'] as String,
      priceProduct: map['priceProduct'] as String,
      amount: map['amount'] as String,
      sum: map['sum'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SQLiteModel.fromJson(String source) => SQLiteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SQLiteModel(id: $id, idProduct: $idProduct, nameProduct: $nameProduct, priceProduct: $priceProduct, amount: $amount, sum: $sum)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SQLiteModel &&
      other.id == id &&
      other.idProduct == idProduct &&
      other.nameProduct == nameProduct &&
      other.priceProduct == priceProduct &&
      other.amount == amount &&
      other.sum == sum;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      idProduct.hashCode ^
      nameProduct.hashCode ^
      priceProduct.hashCode ^
      amount.hashCode ^
      sum.hashCode;
  }
}
