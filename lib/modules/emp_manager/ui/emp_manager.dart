import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yd8/modules/emp_manager/di/emp_manager_di.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';
import 'package:yd8/modules/emp_manager/ui/bloc/emp_manager_bloc.dart';
import 'package:yd8/modules/emp_manager/ui/components/emp_manager_form.dart';
import 'package:yd8/modules/emp_manager/ui/components/emp_manager_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/navigation/nav.dart';

enum _AppliedFilter { search, type }

class EmpManagerPage extends StatefulWidget {
  const EmpManagerPage({super.key});

  @override
  State<EmpManagerPage> createState() => _EmpManagerPageState();
}

class _EmpManagerPageState extends State<EmpManagerPage> {
  List<Emp> emps = [];
  Set<_AppliedFilter> filters = {};
  String s = '';

  void _handleSearch(String input) {
    filters.add(_AppliedFilter.search);
    setState(() => s = input.toLowerCase());
  }

  @override
  void initState() {
    super.initState();
  }

  bool _filterPredicate(Emp emp) {
    bool res = true;

    for (final filter in filters) {
      switch (filter) {
        case _AppliedFilter.search:
          String fullName =
              '${emp.firstName} ${emp.lastName} ${emp.middleName}'
                  .trim()
                  .toLowerCase();

          res = fullName.contains(s);
        case _AppliedFilter.type:
          throw UnimplementedError();
      }
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return BlocProvider<EmpManagerBloc>(
      create: (context) => sl<EmpManagerBloc>(),
      child: AppScaffold(
        title: locale.emp_manager,
        currentRoute: '/emp_manager',
        body: Builder(
          builder: (context) {
            final empBloc = context.watch<EmpManagerBloc>();
            final state = empBloc.state;

            return Scaffold(
              body: Builder(
                builder: (context) {
                  if (state is EmpManagerInitial) {
                    empBloc.add(GetEmps());
                  } else if (state is EmpManagerLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is EmpManagerLoaded) {
                    emps = state.emps;

                    if (emps.isEmpty) {
                      return Center(child: Text(locale.empty));
                    }

                    return EmpManagerList(
                      children:
                          emps.where((emp) => _filterPredicate(emp)).toList(),
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
              appBar:
                  state is EmpManagerLoaded
                      ? _EmpManagerAppBar(
                        title: locale.search,
                        onSearch: _handleSearch,
                        onClose: (_) {
                          setState(() => filters.remove(_AppliedFilter.search));
                        },
                      )
                      : null,
              floatingActionButton: FloatingActionButton(
                onPressed:
                    () => showDialog(
                      context: context,
                      builder:
                          (context) => Dialog.fullscreen(
                            child: EmpManagerForm(empBloc: empBloc),
                          ),
                    ),
                tooltip: locale.new_emp,
                child: Icon(Icons.person_add),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EmpManagerAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function(String) onSearch;
  final Function(void) onClose;

  const _EmpManagerAppBar({
    required this.title,
    required this.onSearch,
    required this.onClose,
  });

  @override
  State<_EmpManagerAppBar> createState() => _EmpManagerAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _EmpManagerAppBarState extends State<_EmpManagerAppBar> {
  bool _showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          _showSearchBar
              ? TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                autofocus: true,
                onChanged: (value) {
                  widget.onSearch(value);
                },
              )
              : Text(widget.title),
      actionsPadding: EdgeInsets.symmetric(horizontal: 8),
      actions: [
        IconButton(
          icon: Icon(_showSearchBar ? Icons.close : Icons.search),
          onPressed: () {
            widget.onClose(null);
            setState(() {
              _showSearchBar = !_showSearchBar;
              if (!_showSearchBar) {
                _searchController.clear();
              }
            });
          },
        ),
      ],
    );
  }
}
