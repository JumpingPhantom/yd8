import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yd8/modules/emp_manager/di/emp_manager_di.dart';
import 'package:yd8/modules/emp_manager/domain/entities.dart';
import 'package:yd8/modules/emp_manager/ui/bloc/emp_manager_bloc.dart';
import 'package:yd8/modules/emp_manager/ui/components/emp_manager_form.dart';
import 'package:yd8/modules/emp_manager/ui/components/emp_manager_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/navigation/nav.dart';

class EmpManagerPage extends StatelessWidget {
  const EmpManagerPage({super.key});

  void _handleSearch(String input) {
    // TODO: implement search
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmpManagerBloc>(
      create: (context) => sl<EmpManagerBloc>(),
      child: AppScaffold(
        title: AppLocalizations.of(context)!.emp_manager,
        currentRoute: '/emp_manager',
        body: Builder(
          builder: (context) {
            final empBloc = context.watch<EmpManagerBloc>();

            return Scaffold(
              body: Builder(
                builder: (context) {
                  if (empBloc.state is EmpManagerInitial) {
                    empBloc.add(GetEmps());
                  } else if (empBloc.state is EmpManagerLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (empBloc.state is EmpManagerLoaded) {
                    List<Emp> emps = (empBloc.state as EmpManagerLoaded).emps;

                    if (emps.isEmpty) {
                      return Center(
                        child: Text(AppLocalizations.of(context)!.empty),
                      );
                    }

                    return EmpManagerList(children: emps);
                  }

                  return SizedBox.shrink();
                },
              ),
              appBar:
                  empBloc.state is EmpManagerLoaded
                      ? _EmpManagerAppBar(
                        title: AppLocalizations.of(context)!.search,
                        onSearch: _handleSearch,
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
                tooltip: AppLocalizations.of(context)!.new_emp,
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

  const _EmpManagerAppBar({required this.title, required this.onSearch});

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
