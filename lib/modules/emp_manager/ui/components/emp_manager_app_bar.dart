import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/filter_dialog.dart';

import '../../domain/types.dart';

class EmpManagerAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function(String) onSearch;
  final Function() onClearSearch;
  final Function() onClearFilters;

  final Function(Set<EmpStatus>) onFilterType;

  const EmpManagerAppBar({
    super.key,
    required this.title,
    required this.onSearch,
    required this.onClearSearch,
    required this.onFilterType,
    required this.onClearFilters,
  });

  @override
  State<EmpManagerAppBar> createState() => _EmpManagerAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _EmpManagerAppBarState extends State<EmpManagerAppBar> {
  final TextEditingController _searchController = TextEditingController();
  Set<EmpStatus> _selectedStatus = {};
  bool _showSearchBar = false;

  void _handleApply(Set<EmpStatus> status) {
    widget.onFilterType(status);

    setState(() {
      _selectedStatus = status;
    });
  }

  void _handleClear() {
    widget.onClearFilters();

    setState(() {
      _selectedStatus.clear();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final isFiltered = _selectedStatus.isNotEmpty;

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
            widget.onClearSearch();
            setState(() {
              _showSearchBar = !_showSearchBar;
              if (!_showSearchBar) {
                _searchController.clear();
              }
            });
          },
        ),

        IconButton(
          icon: Badge(
            isLabelVisible: isFiltered,
            child: Icon(Icons.filter_list),
          ),
          tooltip: locale.filters,
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (context) => FilterDialog(
                    initialSelectedStatus: _selectedStatus,
                    onApply: (status) => _handleApply(status),
                    onClear: () => _handleClear(),
                  ),
            );
          },
        ),
      ],
    );
  }
}
