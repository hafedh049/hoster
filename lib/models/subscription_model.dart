final class SubscriptionModel {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final double price;

  SubscriptionModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.price,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'],
      name: json['name'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'startDate': startDate,
        'endDate': endDate,
        'price': price,
      };
}
