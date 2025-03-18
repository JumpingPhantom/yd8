import 'package:flutter/material.dart';

class EmpManagerAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function(String)? onSearch;

  const EmpManagerAppBar({super.key, this.title = "Search", this.onSearch});

  @override
  State<EmpManagerAppBar> createState() => _EmpManagerAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _EmpManagerAppBarState extends State<EmpManagerAppBar> {
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
                onSubmitted: (value) {
                  if (widget.onSearch != null) {
                    widget.onSearch!(value);
                  }
                },
              )
              : Text(widget.title),
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
