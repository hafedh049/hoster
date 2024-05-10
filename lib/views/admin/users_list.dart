import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../models/user_model.dart';
import '../../utils/callbacks.dart';
import '../../utils/shared.dart';
import 'user_sources.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => UsersListState();
}

class UsersListState extends State<UsersList> with RestorationMixin {
  final RestorableUserSelections _userSelections = RestorableUserSelections();
  final RestorableInt _rowIndex = RestorableInt(0);
  final RestorableInt _rowsPerPage = RestorableInt(PaginatedDataTable.defaultRowsPerPage + 10);
  late UserDataSource _usersDataSource;
  bool _initialized = false;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _columns = <String>["UID", "NAME", "E-MAIL", "PASSWORD", "CLIENT TYPE", "GENDER", "ACTIONS"];
  List<UserModel> _users = <UserModel>[];

  @override
  String get restorationId => 'paginated_user_table';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_userSelections, 'selected_row_indices');
    registerForRestoration(_rowIndex, 'current_row_index');
    registerForRestoration(_rowsPerPage, 'rows_per_page');

    if (!_initialized) {
      _usersDataSource = UserDataSource(context, _users);
      _initialized = true;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _usersDataSource = UserDataSource(context, _users);
      _initialized = true;
    }
  }

  Future<List<dynamic>> _load() async {
    try {
      final Response response = await post(
        Uri.parse("http://localhost/backend/fetch_users.php"),
        headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded'},
      );
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body)["result"];
        data.cast<Map<String, dynamic>>();
        debugPrint("$data");
        // ignore: use_build_context_synchronously
        showToast(context, "Subscription plan has been added.");

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
    _usersDataSource.dispose();
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
              _users = snapshot.data!.map((dynamic e) => UserModel.fromJson(e)).toList();
              _usersDataSource = UserDataSource(context, _users);

              return PaginatedDataTable2(
                //minWidth: 2500, //2450,
                showCheckboxColumn: false,
                showFirstLastButtons: true,
                availableRowsPerPage: const <int>[10, 15, 20],
                rowsPerPage: _rowsPerPage.value,
                onRowsPerPageChanged: (int? value) => _(() => _rowsPerPage.value = value!),
                initialFirstRowIndex: _rowIndex.value,
                onPageChanged: (int rowIndex) => _(() => _rowIndex.value = rowIndex),
                columns: <DataColumn2>[for (final String column in _columns) DataColumn2(label: Text(column), fixedWidth: null, size: ColumnSize.L)],
                source: _usersDataSource,
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
