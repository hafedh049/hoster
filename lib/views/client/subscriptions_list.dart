import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../models/subscription_model.dart';
import '../../utils/callbacks.dart';
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
  final RestorableInt _rowsPerPage = RestorableInt(7);
  late SubscriptionDataSource _subscriptionsDataSource;
  bool _initialized = false;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _columns = <String>["ID", "TOTAL PRICE", "PLAN DURATION", "SUBSCRIPTION DATE", "PLAN NAME"];

  List<SubscriptionModel> _subscriptions = <SubscriptionModel>[];

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

  Future<List<dynamic>> _load() async {
    try {
      final Response response = await post(
        Uri.parse("http://localhost/backend/fetch_subscriptions.php"),
        body: <String, dynamic>{"user_id": db!.get("uid")},
        headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded'},
      );
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body)["result"];
        data.cast<Map<String, dynamic>>();
        return data;
      } else {
        // ignore: use_build_context_synchronously
        showToast(context, "Something went wrong");
        // Handle non-200 status codes (e.g., server errors)
        debugPrint("Error: ${response.statusCode}");
        return <Map<String, dynamic>>[];
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showToast(context, e.toString(), color: red);
      // Handle any other errors, such as network errors
      debugPrint("Error: $e");
      return <Map<String, dynamic>>[];
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
    return FutureBuilder<List<dynamic>>(
      future: _load(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        return StatefulBuilder(
          key: pagerKey,
          builder: (BuildContext context, void Function(void Function()) _) {
            if (snapshot.hasData) {
              _subscriptions = snapshot.data!.map((dynamic e) => SubscriptionModel.fromJson(e)).toList();
              _subscriptionsDataSource = SubscriptionDataSource(context, _subscriptions);

              return PaginatedDataTable2(
                //minWidth: 2500, //2450,
                showCheckboxColumn: false,
                showFirstLastButtons: true,
                availableRowsPerPage: const <int>[3, 5, 7, 10],
                rowsPerPage: _rowsPerPage.value,
                onRowsPerPageChanged: (int? value) => _(() => _rowsPerPage.value = value!),
                initialFirstRowIndex: _rowIndex.value,
                onPageChanged: (int rowIndex) => _(() => _rowIndex.value = rowIndex),
                columns: <DataColumn2>[for (final String column in _columns) DataColumn2(label: Text(column), fixedWidth: null, size: ColumnSize.L)],
                source: _subscriptionsDataSource,
                isHorizontalScrollBarVisible: false,
                isVerticalScrollBarVisible: false,
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text("Something went wrong ${snapshot.error}"));
            }
          },
        );
      },
    );
  }
}
