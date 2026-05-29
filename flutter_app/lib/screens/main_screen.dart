import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/header.dart';
import '../widgets/player_bar.dart';
import '../widgets/now_playing_view.dart';
import '../widgets/glass_widgets.dart';
import 'home_view.dart';
import 'search_view.dart';
import 'library_view.dart';
import 'profile_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  String _activeTab = 'home';
  bool _showNowPlaying = false;
  String _searchQuery = '';
  late AnimationController _tabAnimationController;

  @override
  void initState() {
    super.initState();
    _tabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabAnimationController.dispose();
    super.dispose();
  }

  void _setActiveTab(String tab) {
    setState(() {
      _activeTab = tab;
      _tabAnimationController.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      body: GradientBackground(
        child: Stack(
          children: [
            // Base Layout
            Column(
              children: [
                // Main Workspace (Sidebar + Content)
                Expanded(
                  child: Row(
                    children: [
                      // Sidebar (Hidden on mobile)
                      if (!isMobile)
                        SizedBox(
                          width: 240,
                          child: Sidebar(
                            activeTab: _activeTab,
                            onTabChange: _setActiveTab,
                          ),
                        ),

                      // Main Content Area
                      Expanded(
                        child: Column(
                          children: [
                            Header(
                              showSearch: _activeTab == 'search',
                              onSearch: (val) {
                                setState(() {
                                  _searchQuery = val;
                                });
                              },
                            ),
                            Expanded(
                              child: FadeTransition(
                                opacity: _tabAnimationController,
                                child: _buildContent(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Player Bar (Footer)
                PlayerBar(
                  onNowPlayingOpen: () =>
                      setState(() => _showNowPlaying = true),
                ),
              ],
            ),

            // Now Playing Overlay
            if (_showNowPlaying)
              Positioned.fill(
                child: NowPlayingView(
                  isOpen: _showNowPlaying,
                  onClose: () => setState(() => _showNowPlaying = false),
                ),
              ),
          ],
        ),
      ),
      // Mobile Drawer
      drawer: isMobile
          ? Drawer(
              backgroundColor: theme.scaffoldBackgroundColor,
              child: SafeArea(
                child: Sidebar(
                  activeTab: _activeTab,
                  onTabChange: (tab) {
                    _setActiveTab(tab);
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildContent() {
    switch (_activeTab) {
      case 'search':
        return SearchView(query: _searchQuery);
      case 'library':
        return const LibraryView();
      case 'profile':
        return const ProfileView();
      case 'home':
      default:
        return const HomeView();
    }
  }
}
