import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/header.dart';
import '../widgets/player_bar.dart';
import '../widgets/now_playing_view.dart'; // Ensure created
import 'home_view.dart';
import 'search_view.dart';
import 'library_view.dart';
import 'profile_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _activeTab = 'home';
  bool _showNowPlaying = false;
  String _searchQuery =
      ''; // Shared search state if needed, or local to SearchView

  void _setActiveTab(String tab) {
    setState(() {
      _activeTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check for mobile layout
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFF09090B), // Background dark color
      body: Stack(
        children: [
          // Base Layout
          Column(
            children: [
              // Main Workspace (Sidebar + Content)
              Expanded(
                child: Row(
                  children: [
                    // Sidebar (Hidden on mobile for now, or drawer)
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
                              // For now, search view might handle its own input via the header?
                              // In React code, Header has callbacks.
                              // But SearchView also has its own input UI in some versions.
                              // Let's assume Header updates a provider or pass down.
                              setState(() {
                                _searchQuery = val;
                              });
                            },
                          ),
                          Expanded(
                            child: _buildContent(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Player Bar (Footer)
              PlayerBar(
                onNowPlayingOpen: () => setState(() => _showNowPlaying = true),
              ),
            ],
          ),

          // Overlays
          if (_showNowPlaying)
            Positioned.fill(
              child: NowPlayingView(
                isOpen: _showNowPlaying,
                onClose: () => setState(() => _showNowPlaying = false),
              ),
            ),
        ],
      ),
      // Mobile Drawer if needed
      drawer: isMobile
          ? Drawer(
              backgroundColor: const Color(0xFF09090B),
              child: Sidebar(
                  activeTab: _activeTab,
                  onTabChange: (tab) {
                    _setActiveTab(tab);
                    Navigator.pop(context); // Close drawer
                  }),
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
