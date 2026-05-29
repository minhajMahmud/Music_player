// Example usage of the new Glass UI components

import 'package:flutter/material.dart';
import 'package:tuneflow_music/theme/app_theme.dart';
import 'package:tuneflow_music/widgets/glass_widgets.dart';
import 'package:tuneflow_music/utils/animations.dart';

// Example 1: Basic Glass Card
class ExampleGlassCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      opacity: 0.1,
      padding: EdgeInsets.all(20),
      onTap: () => print('Card tapped'),
      child: Column(
        children: [
          Text('Glass Card', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 8),
          Text('Beautiful glassmorphism effect',
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

// Example 2: Glass Button with Loading State
class ExampleGlassButton extends StatefulWidget {
  @override
  _ExampleGlassButtonState createState() => _ExampleGlassButtonState();
}

class _ExampleGlassButtonState extends State<ExampleGlassButton> {
  bool _isLoading = false;

  Future<void> _handlePress() async {
    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 2));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GlassButton(
      isPrimary: true,
      isLoading: _isLoading,
      onPressed: _handlePress,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Text('Press Me', style: TextStyle(color: Colors.white)),
    );
  }
}

// Example 3: Animated List
class ExampleAnimatedList extends StatelessWidget {
  final items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return AnimatedListItem(
          index: index,
          delay: Duration(milliseconds: 100),
          child: GlassCard(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(items[index]),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
        );
      },
    );
  }
}

// Example 4: Custom Gradient Background
class ExampleGradientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        colors: [
          AppTheme.primaryColor,
          Color(0xFF5856D6),
          AppTheme.primaryDark,
        ],
        child: SafeArea(
          child: Center(
            child: GlassContainer(
              padding: EdgeInsets.all(32),
              child: Text(
                'Beautiful Gradient',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Example 5: Shimmer Loading Placeholder
class ExampleShimmerCard extends StatelessWidget {
  final bool isLoading;

  ExampleShimmerCard({this.isLoading = true});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoading(
            isLoading: isLoading,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 12),
          ShimmerLoading(
            isLoading: isLoading,
            child: Container(
              height: 20,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 8),
          ShimmerLoading(
            isLoading: isLoading,
            child: Container(
              height: 16,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Example 6: Pull to Refresh
class ExamplePullToRefresh extends StatefulWidget {
  @override
  _ExamplePullToRefreshState createState() => _ExamplePullToRefreshState();
}

class _ExamplePullToRefreshState extends State<ExamplePullToRefresh> {
  List<String> items = List.generate(20, (i) => 'Item $i');

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      items = List.generate(20, (i) => 'Refreshed Item $i');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassPullToRefresh(
      onRefresh: _refreshData,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(items[index]));
        },
      ),
    );
  }
}

// Example 7: Page Navigation with Transitions
class ExamplePageTransitions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlassButton(
            onPressed: () => Navigator.push(
              context,
              PageTransitions.slideFromRight(NextScreen()),
            ),
            child: Text('Slide from Right'),
          ),
          SizedBox(height: 16),
          GlassButton(
            onPressed: () => Navigator.push(
              context,
              PageTransitions.slideFromBottom(NextScreen()),
            ),
            child: Text('Slide from Bottom'),
          ),
          SizedBox(height: 16),
          GlassButton(
            onPressed: () => Navigator.push(
              context,
              PageTransitions.fade(NextScreen()),
            ),
            child: Text('Fade'),
          ),
          SizedBox(height: 16),
          GlassButton(
            onPressed: () => Navigator.push(
              context,
              PageTransitions.scale(NextScreen()),
            ),
            child: Text('Scale'),
          ),
        ],
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Next Screen')),
      body: Center(child: Text('You made it!')),
    );
  }
}

// Example 8: Animated Icon Button
class ExampleIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedIconButton(
      icon: Icons.favorite,
      size: 32,
      color: AppTheme.primaryColor,
      onPressed: () => print('Liked!'),
    );
  }
}

// Example 9: Animated Counter
class ExampleCounter extends StatefulWidget {
  @override
  _ExampleCounterState createState() => _ExampleCounterState();
}

class _ExampleCounterState extends State<ExampleCounter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedCounter(
            value: _count,
            style: Theme.of(context).textTheme.displayLarge,
            duration: Duration(milliseconds: 500),
          ),
          SizedBox(height: 16),
          GlassButton(
            onPressed: () => setState(() => _count++),
            child: Text('Increment'),
          ),
        ],
      ),
    );
  }
}

// Example 10: Pulsing Loading Indicator
class ExamplePulsing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PulsingWidget(
        duration: Duration(milliseconds: 1000),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primaryColor, AppTheme.primaryLight],
            ),
            shape: BoxShape.circle,
            boxShadow: AppTheme.glowShadow,
          ),
          child: Icon(Icons.music_note, color: Colors.white, size: 48),
        ),
      ),
    );
  }
}
