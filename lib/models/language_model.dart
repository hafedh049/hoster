import 'package:animated_custom_dropdown/custom_dropdown.dart';

class SubsDuration with CustomDropdownListFilter {
  final String duration;
  const SubsDuration(this.duration);

  @override
  String toString() => duration;

  @override
  bool filter(String query) => duration.toLowerCase().contains(query.toLowerCase());
}
