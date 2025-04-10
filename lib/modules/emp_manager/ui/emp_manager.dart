import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/entities.dart';
import 'bloc/emp_manager.event.dart';
import 'bloc/emp_manager_state.dart';
import 'components/emp_manager_app_bar.dart';
import 'bloc/emp_manager_bloc.dart';
import 'components/emp_manager_form.dart';
import 'components/emp_manager_list.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/common/util.dart';
import '../../../core/navigation/nav.dart';
import '../domain/types.dart';

enum Filter { search, type, status, gender, department }

class EmpManagerPage extends StatefulWidget {
  const EmpManagerPage({super.key});

  @override
  State<EmpManagerPage> createState() => _EmpManagerPageState();
}

class _EmpManagerPageState extends State<EmpManagerPage> {
  List<Emp> emps = [];

  Set<Filter> filters = {};
  Set<EmpStatus> selectedStatus = {};

  String searchQuery = '';

  void _handleSearch(String input) {
    filters.add(Filter.search);
    setState(() => searchQuery = input.toLowerCase());
  }

  void _handleTypeFilter(Set<EmpStatus> selected) {
    filters.add(Filter.type);
    setState(() => selectedStatus = selected);
  }

  bool _filterPredicate(Emp emp) {
    if (filters.isEmpty) {
      return true;
    }

    for (final filter in filters) {
      bool matchesFilter = false;
      switch (filter) {
        case Filter.search:
          final String fullName =
              '${emp.firstName} ${emp.lastName} ${emp.middleName}'
                  .trim()
                  .toLowerCase();
          matchesFilter = fullName.contains(searchQuery);
          break;
        case Filter.type:
          if (selectedStatus.isEmpty) {
            matchesFilter = true;
            break;
          }

          matchesFilter = selectedStatus.contains(emp.status);
          break;
        case Filter.status:
          // TODO: Handle this case.
          throw UnimplementedError('Type filter not yet implemented.');
        case Filter.gender:
          // TODO: Handle this case.
          throw UnimplementedError('Type filter not yet implemented.');
        case Filter.department:
          // TODO: Handle this case.
          throw UnimplementedError('Type filter not yet implemented.');
      }

      if (!matchesFilter) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return BlocProvider<EmpManagerBloc>(
      create: (_) => sl(),
      child: AppScaffold(
        title: locale.emp_manager,
        currentRoute: '/emp_manager',
        body: BlocBuilder<EmpManagerBloc, EmpManagerState>(
          builder: (context, state) {
            final bloc = context.read<EmpManagerBloc>();

            return Scaffold(
              appBar:
                  state is EmpManagerLoaded
                      ? EmpManagerAppBar(
                        title: locale.search,
                        onSearch: _handleSearch,
                        onFilterType: _handleTypeFilter,
                        onClearSearch: () {
                          setState(() => filters.remove(Filter.search));
                        },
                        onClearFilters: () {
                          setState(() {
                            selectedStatus = {};
                          });
                        },
                      )
                      : null,
              body: Builder(
                builder: (_) {
                  if (state is EmpManagerInitial) {
                    bloc.add(GetEmps());
                  } else if (state is EmpManagerLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is EmpManagerLoaded) {
                    emps = state.emps;

                    if (emps.isEmpty) {
                      return Center(child: Text(locale.empty));
                    }

                    return EmpManagerList(
                      emps: emps.where((emp) => _filterPredicate(emp)).toList(),
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed:
                    () => showDialog(
                      context: context,
                      builder:
                          (_) => Dialog.fullscreen(
                            child: EmpManagerForm(empBloc: bloc),
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
