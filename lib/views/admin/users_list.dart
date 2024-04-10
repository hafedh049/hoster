import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../utils/shared.dart';
import 'data_sources.dart';

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

  @override
  String get restorationId => 'paginated_user_table';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_userSelections, 'selected_row_indices');
    registerForRestoration(_rowIndex, 'current_row_index');
    registerForRestoration(_rowsPerPage, 'rows_per_page');

    if (!_initialized) {
      _usersDataSource = UserDataSource(context, users);
      _initialized = true;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _usersDataSource = UserDataSource(context, users);
      _initialized = true;
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
    return StatefulBuilder(
      key: pagerKey,
      builder: (BuildContext context, void Function(void Function()) _) {
        _usersDataSource = UserDataSource(context, users);
        return PaginatedDataTable2(
          minWidth: 1500, //2450,
          showCheckboxColumn: false,
          showFirstLastButtons: true,
          availableRowsPerPage: const <int>[20, 30],
          rowsPerPage: _rowsPerPage.value,
          onRowsPerPageChanged: (int? value) => _(() => _rowsPerPage.value = value!),
          initialFirstRowIndex: _rowIndex.value,
          onPageChanged: (int rowIndex) => _(() => _rowIndex.value = rowIndex),
          columns: <DataColumn2>[for (final String column in columns) DataColumn2(label: Text(column), fixedWidth: null, size: ColumnSize.L)],
          source: _usersDataSource,
          isHorizontalScrollBarVisible: true,
        );
      },
    );
  }
}
