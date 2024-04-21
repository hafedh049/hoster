// ignore_for_file: use_build_context_synchronously

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/services.dart';

import '../../models/subscription_model.dart';
import '../../utils/callbacks.dart';

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
        DataCell(
          Tooltip(message: subscription.id, child: Text(subscription.id)),
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: subscription.id));
            showToast(context, "ID has been copied to clipboard");
          },
        ),
        DataCell(
          Tooltip(message: subscription.name, child: Text(subscription.name)),
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: subscription.name));
            showToast(context, "Name has been copied to clipboard");
          },
        ),
        DataCell(
          Tooltip(message: subscription.startDate.toString(), child: Text(formatDate(subscription.startDate, const <String>[dd, MM, yyyy]))),
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: subscription.startDate.toString()));
            showToast(context, "Start date has been copied to clipboard");
          },
        ),
        DataCell(
          Tooltip(message: subscription.endDate.toString(), child: Text(formatDate(subscription.endDate, const <String>[dd, MM, yyyy]))),
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: subscription.endDate.toString()));
            showToast(context, "End date has been copied to clipboard");
          },
        ),
        DataCell(
          Tooltip(message: subscription.price.toStringAsFixed(2), child: Text(subscription.price.toStringAsFixed(2))),
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: subscription.price.toStringAsFixed(2)));
            showToast(context, "Price has been copied to clipboard");
          },
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
