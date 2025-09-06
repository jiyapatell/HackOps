import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../routes/app_routes.dart';

class Sidebar extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onToggle;

  const Sidebar({
    super.key,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    if (widget.isExpanded) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(Sidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.sidebarBackground,
        border: Border(
          right: BorderSide(color: AppColors.borderColor),
        ),
      ),
      child: Column(
        children: [
          // Logo/Brand area
          Container(
            height: 80,
            padding: const EdgeInsets.all(16),
            child: widget.isExpanded
                ? Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: AppColors.primaryGradient,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryBlue.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.bug_report,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Handy Crab',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: AppColors.primaryGradient,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryBlue.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.bug_report,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
          ),
          
          const Divider(color: AppColors.dividerColor),
          
          // Navigation items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                _buildNavItem(
                  icon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  isSelected: false,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.dashboard),
                ),
                const SizedBox(height: 8),
                _buildNavItem(
                  icon: Icons.folder_outlined,
                  label: 'Projects',
                  isSelected: true,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.projectsView),
                ),
                const SizedBox(height: 8),
                _buildNavItem(
                  icon: Icons.task_alt_outlined,
                  label: 'My Tasks',
                  isSelected: false,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.trello),
                ),
                const SizedBox(height: 8),
                _buildNavItem(
                  icon: Icons.people_outline,
                  label: 'Team',
                  isSelected: false,
                ),
                const SizedBox(height: 8),
                _buildNavItem(
                  icon: Icons.analytics_outlined,
                  label: 'Analytics',
                  isSelected: false,
                ),
              ],
            ),
          ),
          
          const Divider(color: AppColors.dividerColor),
          
          // Theme toggle
          Padding(
            padding: const EdgeInsets.all(16),
            child: widget.isExpanded
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Theme',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                _buildThemeButton(
                                  icon: Icons.light_mode,
                                  isSelected: !_isDarkMode,
                                  onTap: () {
                                    setState(() {
                                      _isDarkMode = false;
                                    });
                                  },
                                ),
                                _buildThemeButton(
                                  icon: Icons.dark_mode,
                                  isSelected: _isDarkMode,
                                  onTap: () {
                                    setState(() {
                                      _isDarkMode = true;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: AppColors.secondaryText,
                        size: 20,
                      ),
                    ),
                  ),
          ),
          
          // User profile
          Container(
            padding: const EdgeInsets.all(16),
            child: widget.isExpanded
                ? Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryBlue,
                            width: 2,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primaryBlue,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Test User',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryText,
                                fontSize: 14,
                              ),
                            ),
                            const Text(
                              'user@mail.com',
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surfaceColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert,
                            color: AppColors.secondaryText,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryBlue,
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primaryBlue,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected 
                  ? AppColors.primaryBlue.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isSelected 
                  ? Border.all(
                      color: AppColors.primaryBlue.withOpacity(0.2),
                      width: 1,
                    )
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? AppColors.primaryBlue
                        : AppColors.surfaceColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected 
                        ? Colors.white
                        : AppColors.secondaryText,
                    size: 18,
                  ),
                ),
                if (widget.isExpanded) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        label,
                        style: TextStyle(
                          color: isSelected 
                              ? AppColors.primaryBlue 
                              : AppColors.secondaryText,
                          fontWeight: isSelected 
                              ? FontWeight.w600 
                              : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeButton({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.primaryBlue
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isSelected 
              ? Colors.white
              : AppColors.secondaryText,
          size: 16,
        ),
      ),
    );
  }
}