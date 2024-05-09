final class SubscriptionModel {
  final String subscriptionID;
  final int totalPrice;
  final int planDuration;
  final DateTime subscriptionDate;
  final String planName;

  SubscriptionModel({
    required this.subscriptionID,
    required this.totalPrice,
    required this.planDuration,
    required this.subscriptionDate,
    required this.planName,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      subscriptionID: json['subscription_id'],
      totalPrice: json['total_price'],
      planDuration: json['plan_duration'],
      subscriptionDate: DateTime.parse(json['subscription_date']),
      planName: json['plan_name'],
    );
  }
}
