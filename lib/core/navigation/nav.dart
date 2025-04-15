import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationItem {
  final String title;
  final IconData icon;
  final String route;

  NavigationItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}

class SidebarNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final List<NavigationItem> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double width;

  const SidebarNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.width = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'yd8',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildNavItem(context, index);
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index) {
    final isSelected = selectedIndex == index;
    final item = items[index];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:
            isSelected
                ? (selectedItemColor ?? Theme.of(context).colorScheme.primary)
                    .withValues(alpha: 0.1)
                : Colors.transparent,
      ),
      child: InkWell(
        onTap: () => onItemSelected(index),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                item.icon,
                color:
                    isSelected
                        ? selectedItemColor ??
                            Theme.of(context).colorScheme.primary
                        : unselectedItemColor ??
                            Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 16),
              Text(
                item.title,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color:
                      isSelected
                          ? selectedItemColor ??
                              Theme.of(context).colorScheme.primary
                          : unselectedItemColor ??
                              Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppScaffold extends StatefulWidget {
  final Widget body;
  final String title;
  final String currentRoute;

  const AppScaffold({
    super.key,
    required this.body,
    required this.title,
    required this.currentRoute,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  List<NavigationItem> _navItems = [];

  int _getSelectedIndex() {
    for (int i = 0; i < _navItems.length; i++) {
      if (_navItems[i].route == widget.currentRoute) {
        return i;
      }
    }
    return 0;
  }

  void _onItemSelected(int index, BuildContext context) {
    Navigator.pushReplacementNamed(context, _navItems[index].route);
  }

  @override
  Widget build(BuildContext context) {
    _navItems = [
      NavigationItem(
        title: AppLocalizations.of(context)!.dashboard,
        icon: Icons.dashboard,
        route: '/',
      ),
      NavigationItem(
        title: AppLocalizations.of(context)!.emp_manager,
        icon: Icons.people,
        route: '/emp_manager',
      ),
      NavigationItem(
        title: AppLocalizations.of(context)!.statistics,
        icon: Icons.bar_chart,
        route: '/stats',
      ),
      NavigationItem(
        title: AppLocalizations.of(context)!.settings,
        icon: Icons.settings,
        route: '/settings',
      ),
    ];

    final selectedIndex = _getSelectedIndex();

    return Scaffold(
      appBar: AppBar(
        title:
            MediaQuery.of(context).size.width < 600 ? Text(widget.title) : null,
        forceMaterialTransparency: true,
        leading: Builder(
          builder: (context) {
            return MediaQuery.of(context).size.width < 600
                ? IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                )
                : SizedBox.shrink();
          },
        ),
      ),

      drawer:
          MediaQuery.of(context).size.width < 600
              ? Drawer(
                child: SidebarNavigation(
                  selectedIndex: selectedIndex,
                  onItemSelected: (index) {
                    Navigator.pop(context); // Close drawer
                    _onItemSelected(index, context);
                  },
                  items: _navItems,
                ),
              )
              : null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 600)
            SidebarNavigation(
              selectedIndex: selectedIndex,
              onItemSelected: (index) => _onItemSelected(index, context),
              items: _navItems,
            ),

          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              child: widget.body,
            ),
          ),
        ],
      ),
    );
  }
}
