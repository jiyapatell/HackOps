import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class ProjectsHeader extends StatelessWidget {
  final String title;
  final List<String> breadcrumbs;
  final List<Widget>? actions;
  final VoidCallback? onMenuTap;

  const ProjectsHeader({
    super.key,
    required this.title,
    this.breadcrumbs = const [],
    this.actions,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Container(
      height: isMobile ? 70 : 80,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          bottom: BorderSide(color: AppColors.borderColor),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
        child: isMobile ? _buildMobileHeader() : _buildDesktopHeader(),
      ),
    );
  }

  Widget _buildMobileHeader() {
    return Column(
      children: [
        // Top row with menu and title
        Row(
          children: [
            // Mobile menu button
            if (onMenuTap != null)
              IconButton(
                onPressed: onMenuTap,
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.menu,
                    color: AppColors.primaryText,
                    size: 20,
                  ),
                ),
              ),
            
            // Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // Mobile action buttons
            if (actions != null) ...actions!,
          ],
        ),
        
        const SizedBox(height: 8),
        
        // Bottom row with breadcrumbs
        if (breadcrumbs.isNotEmpty)
          Row(
            children: [
              const Icon(
                Icons.home_outlined,
                color: AppColors.secondaryText,
                size: 14,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  breadcrumbs.join(' > '),
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildDesktopHeader() {
    return Row(
      children: [
        // Breadcrumb navigation
        if (breadcrumbs.isNotEmpty) ...[
          Expanded(
            child: Row(
              children: [
                const Icon(
                  Icons.home_outlined,
                  color: AppColors.secondaryText,
                  size: 16,
                ),
                const SizedBox(width: 8),
                ...breadcrumbs.asMap().entries.map((entry) {
                  final index = entry.key;
                  final breadcrumb = entry.value;
                  return Row(
                    children: [
                      Text(
                        breadcrumb,
                        style: TextStyle(
                          color: index == breadcrumbs.length - 1
                              ? AppColors.primaryText
                              : AppColors.secondaryText,
                          fontSize: 14,
                          fontWeight: index == breadcrumbs.length - 1
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                      if (index < breadcrumbs.length - 1) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.chevron_right,
                          color: AppColors.secondaryText,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                      ],
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ] else
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
            ),
          ),
        
        const SizedBox(width: 24),
        
        // Action buttons
        if (actions != null) ...actions!,
      ],
    );
  }
}
