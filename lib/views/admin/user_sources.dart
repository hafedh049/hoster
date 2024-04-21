// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/services.dart';
import 'package:hoster/utils/shared.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../models/user_model.dart';
import '../../utils/callbacks.dart';

class RestorableUserSelections extends RestorableProperty<Set<int>> {
  Set<int> _userSelections = <int>{};

  bool isSelected(int index) => _userSelections.contains(index);

  @override
  Set<int> createDefaultValue() => _userSelections;

  @override
  Set<int> fromPrimitives(Object? data) {
    final selectedItemIndices = data as List<dynamic>;
    _userSelections = <int>{...selectedItemIndices.map<int>((dynamic id) => id as int)};
    return _userSelections;
  }

  @override
  void initWithValue(Set<int> value) {
    _userSelections = value;
  }

  @override
  Object toPrimitives() => _userSelections.toList();
}

class UserDataSource extends DataTableSource {
  UserDataSource.empty(this.context) {
    users = <UserModel>[];
  }

  UserDataSource(this.context, this.users);

  final BuildContext context;
  List<UserModel> users = <UserModel>[];
  final bool hasRowTaps = true;
  final bool hasRowHeightOverrides = true;
  final bool hasZebraStripes = true;

  @override
  DataRow2 getRow(int index, [Color? color]) {
    assert(index >= 0);
    if (index >= users.length) throw 'index > _users.length';
    final UserModel user = users[index];
    return DataRow2.byIndex(
      index: index,
      color: color != null ? MaterialStateProperty.all(color) : (hasZebraStripes && index.isEven ? MaterialStateProperty.all(Theme.of(context).highlightColor) : null),
      cells: <DataCell>[
        DataCell(
          Tooltip(message: user.uid, child: Text(user.uid)),
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: user.uid));
            showToast(context, "UID has been copied to clipboard");
          },
        ),
        DataCell(
          Tooltip(message: user.name, child: Text(user.name)),
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: user.name));
            showToast(context, "Name has been copied to clipboard");
          },
        ),
        DataCell(
          Tooltip(message: user.email, child: Text(user.email)),
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: user.email));
            showToast(context, "E-mail has been copied to clipboard");
          },
        ),
        DataCell(
          Tooltip(message: user.password, child: Text(user.password)),
          onTap: () => showToast(context, "Can't copy password's hash"),
        ),
        DataCell(
          Tooltip(message: user.clientType, child: Text(user.clientType)),
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: user.name));
            showToast(context, "Client type has been copied to clipboard");
          },
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(onPressed: () {}, icon: const Icon(FontAwesome.pencil_solid, size: 20, color: Colors.greenAccent)),
              IconButton(onPressed: () {}, icon: const Icon(FontAwesome.trash_solid, size: 20, color: red)),
            ],
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => users.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => users.length;
}
