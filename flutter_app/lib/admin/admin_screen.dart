import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/admin_sidebar.dart';
import 'components/admin_header.dart';
import 'views/dashboard_view.dart';
import 'views/songs_view.dart';
import 'views/artists_view.dart';
import 'views/albums_view.dart';
import 'views/users_view.dart';
import 'views/subscriptions_view.dart';
import 'views/analytics_view.dart';
import 'views/settings_view.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String _activeTab = 'dashboard';
  bool _sidebarCollapsed = false;

  final Map<String, String> _tabTitles = {
    'dashboard': 'Dashboard',
    'songs': 'Songs',
    'artists': 'Artists',
    'albums': 'Albums',
    'users': 'Users',
    'subscriptions': 'Subscriptions',
    'analytics': 'Analytics',
    'settings': 'Settings',
  };

  void onTabChanged(String tab) {
    setState(() {
      _activeTab = tab;
    });
  }

  void onToggleCollapse() {
    setState(() {
      _sidebarCollapsed = !_sidebarCollapsed;
    });
  }

  Widget _buildContent() {
    switch (_activeTab) {
      case 'songs':
        return const SongsView();
      case 'artists':
        return const ArtistsView();
      case 'albums':
        return const AlbumsView();
      case 'users':
        return const UsersView();
      case 'subscriptions':
        return const SubscriptionsView();
      case 'analytics':
        return const AnalyticsView();
      case 'settings':
        return const SettingsView();
      default:
        return const DashboardView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Row(
        children: [
          AdminSidebar(
            activeTab: _activeTab,
            onTabChange: onTabChanged,
            collapsed: _sidebarCollapsed,
            onToggleCollapse: onToggleCollapse,
          ),
          Expanded(
            child: Column(
              children: [
                AdminHeader(title: _tabTitles[_activeTab] ?? 'Admin'),
                Expanded(
                  child: _buildContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
