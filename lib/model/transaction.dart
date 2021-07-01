class Transaction {

  Transaction({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.reference,
    this.accessCode,
    this.status,
    this.totalAmount,
    this.totalHire,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String user;
  String reference;
  String accessCode;
  String status;
  double totalAmount;
  int totalHire;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: json["user"],
    reference: json["reference"],
    accessCode: json["access_code"],
    status: json["status"],
    totalAmount: json["total_amount"] == null ? null : double.parse(json["total_amount"].toString()),
    totalHire: json["total_hire"] == null ? null : int.parse(json["total_hire"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user,
    "reference": reference,
    "access_code": accessCode,
    "status": status,
    "total_amount": totalAmount,
    "total_hire": totalHire,
  };
}