import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A widget that animates its child when it appears in the viewport.
///
/// This widget uses the [VisibilityDetector] to determine when it's visible,
/// and then plays an entrance animation.
class AnimatedSection extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offset;

  const AnimatedSection({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.offset = 0.2,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.offset),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    // Add a post-frame callback to start the animation after the first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Start the animation when widget is first built
      _onVisibilityChanged(true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(bool isVisible) {
    if (isVisible && !_isVisible) {
      setState(() {
        _isVisible = true;
      });
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          // Simple approach to check visibility
          final RenderObject? renderObject = context.findRenderObject();
          if (renderObject != null && renderObject is RenderBox) {
            final RenderAbstractViewport viewport =
                RenderAbstractViewport.of(renderObject);
            final RevealedOffset revealedOffset =
                viewport.getOffsetToReveal(renderObject, 0.0);
            if (revealedOffset.offset < 0) {
              // Widget is visible in the viewport
              _onVisibilityChanged(true);
            }
          }
        }
        return false;
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
