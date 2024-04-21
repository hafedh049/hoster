import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../models/subscription_model.dart';
import '../../utils/shared.dart';
import 'subscription_sources.dart';

class SubscriptionsList extends StatefulWidget {
  const SubscriptionsList({super.key});

  @override
  State<SubscriptionsList> createState() => SubscriptionsListState();
}

class SubscriptionsListState extends State<SubscriptionsList> with RestorationMixin {
  final RestorableSubscriptionSelections _subscriptionSelections = RestorableSubscriptionSelections();
  final RestorableInt _rowIndex = RestorableInt(0);
  final RestorableInt _rowsPerPage = RestorableInt(PaginatedDataTable.defaultRowsPerPage + 10);
  late SubscriptionDataSource _subscriptionsDataSource;
  bool _initialized = false;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _columns = <String>["Plan name", "Start Date", "End Date", "Price"];

  final List<SubscriptionModel> _subscriptions = <SubscriptionModel>[];

  @override
  String get restorationId => 'paginated_subscription_table';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_subscriptionSelections, 'selected_row_indices');
    registerForRestoration(_rowIndex, 'current_row_index');
    registerForRestoration(_rowsPerPage, 'rows_per_page');

    if (!_initialized) {
      _subscriptionsDataSource = SubscriptionDataSource(context, _subscriptions);
      _initialized = true;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _subscriptionsDataSource = SubscriptionDataSource(context, _subscriptions);
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _rowsPerPage.dispose();
    _subscriptionsDataSource.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      key: pagerKey,
      builder: (BuildContext context, void Function(void Function()) _) {
        _subscriptionsDataSource = SubscriptionDataSource(context, _subscriptions);
        return PaginatedDataTable2(
          minWidth: 1500, //2450,
          showCheckboxColumn: false,
          showFirstLastButtons: true,
          availableRowsPerPage: const <int>[20, 30],
          rowsPerPage: _rowsPerPage.value,
          onRowsPerPageChanged: (int? value) => _(() => _rowsPerPage.value = value!),
          initialFirstRowIndex: _rowIndex.value,
          onPageChanged: (int rowIndex) => _(() => _rowIndex.value = rowIndex),
          columns: <DataColumn2>[for (final String column in _columns) DataColumn2(label: Text(column), fixedWidth: null, size: ColumnSize.L)],
          source: _subscriptionsDataSource,
          isHorizontalScrollBarVisible: true,
        );
      },
    );
  }
}
