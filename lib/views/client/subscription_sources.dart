import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

import '../../models/subscription_model.dart';

class RestorableSubscriptionSelections extends RestorableProperty<Set<int>> {
  Set<int> _subscriptionSelections = <int>{};

  bool isSelected(int index) => _subscriptionSelections.contains(index);

  @override
  Set<int> createDefaultValue() => _subscriptionSelections;

  @override
  Set<int> fromPrimitives(Object? data) {
    final selectedItemIndices = data as List<dynamic>;
    _subscriptionSelections = <int>{...selectedItemIndices.map<int>((dynamic id) => id as int)};
    return _subscriptionSelections;
  }

  @override
  void initWithValue(Set<int> value) {
    _subscriptionSelections = value;
  }

  @override
  Object toPrimitives() => _subscriptionSelections.toList();
}

class SubscriptionDataSource extends DataTableSource {
  SubscriptionDataSource.empty(this.context) {
    subscriptions = <SubscriptionModel>[];
  }

  SubscriptionDataSource(this.context, this.subscriptions);

  final BuildContext context;
  List<SubscriptionModel> subscriptions = <SubscriptionModel>[];
  final bool hasRowTaps = true;
  final bool hasRowHeightOverrides = true;
  final bool hasZebraStripes = true;

  @override
  DataRow2 getRow(int index, [Color? color]) {
    assert(index >= 0);
    if (index >= subscriptions.length) throw 'index > _subscriptions.length';
    final SubscriptionModel subscription = subscriptions[index];
    return DataRow2.byIndex(
      index: index,
      color: color != null ? MaterialStateProperty.all(color) : (hasZebraStripes && index.isEven ? MaterialStateProperty.all(Theme.of(context).highlightColor) : null),
      cells: <DataCell>[
        DataCell(Text(subscription.subscriptionID)),
        DataCell(Text(subscription.totalPrice.toString())),
        DataCell(Text(subscription.planDuration.toString())),
        DataCell(Text(formatDate(subscription.subscriptionDate, const <String>[dd, " ", MM, " ", yyyy]))),
        DataCell(
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.lightGreenAccent.withOpacity(.5)),
            child: Text(subscription.planName.toUpperCase()),
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => subscriptions.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => subscriptions.length;
}
