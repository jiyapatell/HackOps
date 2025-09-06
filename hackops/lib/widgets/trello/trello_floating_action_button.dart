import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class TrelloFloatingActionButton extends StatefulWidget {
  final VoidCallback? onAddCard;
  final VoidCallback? onAddBoard;
  final VoidCallback? onAddList;

  const TrelloFloatingActionButton({
    super.key,
    this.onAddCard,
    this.onAddBoard,
    this.onAddList,
  });

  @override
  State<TrelloFloatingActionButton> createState() => _TrelloFloatingActionButtonState();
}

class _TrelloFloatingActionButtonState extends State<TrelloFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.125, // 45 degrees
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background overlay
        if (_isExpanded)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleExpanded,
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
        
        // Action buttons
        Positioned(
          bottom: 20,
          right: 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add Card button
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _scaleAnimation,
                  child: _buildActionButton(
                    icon: Icons.add_card,
                    label: 'Add Card',
                    onTap: () {
                      widget.onAddCard?.call();
                      _toggleExpanded();
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Add List button
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _scaleAnimation,
                  child: _buildActionButton(
                    icon: Icons.view_list,
                    label: 'Add List',
                    onTap: () {
                      widget.onAddList?.call();
                      _toggleExpanded();
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Add Board button
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _scaleAnimation,
                  child: _buildActionButton(
                    icon: Icons.dashboard,
                    label: 'Add Board',
                    onTap: () {
                      widget.onAddBoard?.call();
                      _toggleExpanded();
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Main FAB
              RotationTransition(
                turns: _rotationAnimation,
                child: FloatingActionButton(
                  onPressed: _toggleExpanded,
                  backgroundColor: AppColors.primaryBlue,
                  child: Icon(
                    _isExpanded ? Icons.close : Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.primaryText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: onTap,
            icon: Icon(
              icon,
              color: AppColors.primaryBlue,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
