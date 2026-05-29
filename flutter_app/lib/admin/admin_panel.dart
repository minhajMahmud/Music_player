
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'admin_header.dart';
import 'admin_sidebar.dart';
import 'admin_settings.dart';
import 'admin_store.dart';

import 'views/dashboard_view.dart';
import 'views/songs_view.dart';
import 'views/artists_view.dart';
import 'views/albums_view.dart';
import 'views/users_view.dart';
import 'views/subscriptions_view.dart';
import 'views/analytics_view.dart';
import 'views/settings_view.dart';

/// Drop-in screen for your Admin Dashboard.
///
/// ✅ Features implemented:
/// - Responsive layout (sidebar on desktop, drawer on small screens)
/// - Tab navigation (Dashboard, Songs, Artists, Albums, Users, Subscriptions, Analytics, Settings)
/// - Global search that filters tables/cards in each view
/// - Full CRUD UI (add/edit/delete) for Songs/Artists/Albums/Users/Subscriptions (in-memory store)
/// - Derived analytics charts (no external chart packages)
/// - Settings toggles (theme etc.)
///
/// How to use:
///   home: const AdminPanel()
class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final AdminStore _store = AdminStore();
  final AdminSettings _settings = AdminSettings();

  String _activeTab = 'dashboard';
  bool _sidebarCollapsed = false;
  String _searchQuery = '';

  @override
  void dispose() {
    _store.dispose();
    _settings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _settings,
      builder: (context, _) {
        final theme = _settings.darkMode ? _darkTheme() : _lightTheme();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: _ScaffoldShell(
            store: _store,
            settings: _settings,
            activeTab: _activeTab,
            onTabChange: (t) => setState(() => _activeTab = t),
            sidebarCollapsed: _sidebarCollapsed,
            onToggleCollapse: () =>
                setState(() => _sidebarCollapsed = !_sidebarCollapsed),
            searchQuery: _searchQuery,
            onSearchChanged: (q) => setState(() => _searchQuery = q),
          ),
        );
      },
    );
  }

  ThemeData _darkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0b0b0f),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: Colors.orange,
      ),
      dividerColor: Colors.grey.shade800,
      dialogBackgroundColor: const Color(0xFF18181b),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF18181b),
        contentTextStyle: const TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: const Color(0xFFf6f6f7),
      colorScheme: const ColorScheme.light().copyWith(
        primary: Colors.orange,
      ),
      dividerColor: Colors.grey.shade300,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.black87,
        contentTextStyle: const TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _ScaffoldShell extends StatelessWidget {
  final AdminStore store;
  final AdminSettings settings;

  final String activeTab;
  final ValueChanged<String> onTabChange;

  final bool sidebarCollapsed;
  final VoidCallback onToggleCollapse;

  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  const _ScaffoldShell({
    required this.store,
    required this.settings,
    required this.activeTab,
    required this.onTabChange,
    required this.sidebarCollapsed,
    required this.onToggleCollapse,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isNarrow = w < 1000;

    final sidebar = AdminSidebar(
      activeTab: activeTab,
      onTabChange: (t) {
        onTabChange(t);
        if (isNarrow) Navigator.of(context).maybePop(); // close drawer
      },
      collapsed: sidebarCollapsed && !isNarrow,
      onToggleCollapse: onToggleCollapse,
    );

    final header = AdminHeader(
      title: _titleFor(activeTab),
      onSearchChanged: onSearchChanged,
      hideSearch: isNarrow,
      actions: [
        IconButton(
          tooltip: settings.darkMode ? 'Switch to light' : 'Switch to dark',
          icon: Icon(settings.darkMode ? LucideIcons.sun : LucideIcons.moon,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black87),
          onPressed: () => settings.setDarkMode(!settings.darkMode),
        ),
        if (isNarrow)
          IconButton(
            tooltip: 'Search',
            icon: Icon(LucideIcons.search,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black87),
            onPressed: () => _openSearchDialog(context),
          ),
      ],
    );

    final body = AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        return _activeView(activeTab, store, settings, searchQuery);
      },
    );

    return Scaffold(
      drawer: isNarrow
          ? Drawer(
              backgroundColor: const Color(0xFF18181b),
              child: SafeArea(child: sidebar),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (!isNarrow) sidebar,
            Expanded(
              child: Column(
                children: [
                  header,
                  Expanded(
                    child: Container(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF0b0b0f)
                          : const Color(0xFFf6f6f7),
                      child: body,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _titleFor(String tab) {
    switch (tab) {
      case 'songs':
        return 'Songs';
      case 'artists':
        return 'Artists';
      case 'albums':
        return 'Albums';
      case 'users':
        return 'Users';
      case 'subscriptions':
        return 'Subscriptions';
      case 'analytics':
        return 'Analytics';
      case 'settings':
        return 'Settings';
      default:
        return 'Dashboard';
    }
  }

  Widget _activeView(
      String tab, AdminStore store, AdminSettings settings, String q) {
    switch (tab) {
      case 'songs':
        return SongsView(store: store, searchQuery: q);
      case 'artists':
        return ArtistsView(store: store, searchQuery: q);
      case 'albums':
        return AlbumsView(store: store, searchQuery: q);
      case 'users':
        return UsersView(store: store, searchQuery: q);
      case 'subscriptions':
        return SubscriptionsView(store: store, searchQuery: q);
      case 'analytics':
        return AnalyticsView(store: store);
      case 'settings':
        return SettingsView(settings: settings);
      case 'logout':
        return const Center(child: Text('Logged out'));
      default:
        return DashboardView(store: store);
    }
  }

  Future<void> _openSearchDialog(BuildContext context) async {
    final controller = TextEditingController(text: searchQuery);
    final res = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF18181b),
        title: const Text('Search', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Type to search…',
            hintStyle: TextStyle(color: Colors.grey.shade400),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade800),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange.shade400),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade400,
              foregroundColor: Colors.black,
            ),
            child: const Text('Apply'),
          ),
        ],
      ),
    );

    if (res != null) onSearchChanged(res);
  }
}
