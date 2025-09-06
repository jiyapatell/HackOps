import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class AppHeader extends StatefulWidget {
  final String title;
  final List<String> breadcrumbs;
  final List<Widget>? actions;
  final VoidCallback? onMenuTap;

  const AppHeader({
    super.key,
    required this.title,
    this.breadcrumbs = const [],
    this.actions,
    this.onMenuTap,
  });

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchFocused = false;

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
        // Top row with menu and company selector
        Row(
          children: [
            // Mobile menu button
            if (widget.onMenuTap != null)
              IconButton(
                onPressed: widget.onMenuTap,
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
            
            // Company selector (smaller on mobile)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentBlue,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: AppColors.primaryBlue,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    const Text(
                      'Company',
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primaryBlue,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(width: 8),
            
            // Mobile action buttons (only essential ones)
            _buildActionButton(
              icon: Icons.notifications_outlined,
              label: 'Notifications',
              onTap: () {},
            ),
            
            const SizedBox(width: 8),
            
            _buildActionButton(
              icon: Icons.add,
              label: 'Add',
              onTap: () {},
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        // Bottom row with title/breadcrumbs
        Row(
          children: [
            if (widget.breadcrumbs.isNotEmpty) ...[
              const Icon(
                Icons.home_outlined,
                color: AppColors.secondaryText,
                size: 14,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  widget.breadcrumbs.join(' > '),
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ] else
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
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
        // Company selector
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.accentBlue,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: true,
                onChanged: (value) {},
                activeColor: AppColors.primaryBlue,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              const Text(
                'Company',
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.primaryBlue,
                size: 16,
              ),
            ],
          ),
        ),
        
        const SizedBox(width: 24),
        
        // Breadcrumb navigation
        if (widget.breadcrumbs.isNotEmpty) ...[
          Expanded(
            child: Row(
              children: [
                const Icon(
                  Icons.home_outlined,
                  color: AppColors.secondaryText,
                  size: 16,
                ),
                const SizedBox(width: 8),
                ...widget.breadcrumbs.asMap().entries.map((entry) {
                  final index = entry.key;
                  final breadcrumb = entry.value;
                  return Row(
                    children: [
                      Text(
                        breadcrumb,
                        style: TextStyle(
                          color: index == widget.breadcrumbs.length - 1
                              ? AppColors.primaryText
                              : AppColors.secondaryText,
                          fontSize: 14,
                          fontWeight: index == widget.breadcrumbs.length - 1
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                      if (index < widget.breadcrumbs.length - 1) ...[
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
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
            ),
          ),
        
        const SizedBox(width: 24),
        
        // Search bar
        Expanded(
          flex: 2,
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                _isSearchFocused = hasFocus;
              });
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: _isSearchFocused 
                    ? AppColors.cardBackground 
                    : AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isSearchFocused 
                      ? AppColors.focusBorder 
                      : AppColors.borderColor,
                  width: _isSearchFocused ? 2 : 1,
                ),
                boxShadow: _isSearchFocused ? [
                  BoxShadow(
                    color: AppColors.focusBorder.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ] : null,
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search projects, tasks, or team members...',
                  hintStyle: const TextStyle(
                    color: AppColors.lightText,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: _isSearchFocused 
                        ? AppColors.primaryBlue 
                        : AppColors.secondaryText,
                    size: 20,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: AppColors.secondaryText,
                            size: 18,
                          ),
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Action buttons
        Row(
          children: [
            // Quick actions
            _buildActionButton(
              icon: Icons.add,
              label: 'Quick Add',
              onTap: () {},
            ),
            
            const SizedBox(width: 8),
            
            // Notifications
            _buildNotificationButton(),
            
            const SizedBox(width: 8),
            
            // Settings
            _buildActionButton(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: () {},
            ),
            
            const SizedBox(width: 16),
            
            // Custom actions
            if (widget.actions != null) ...widget.actions!,
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surfaceColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Icon(
              icon,
              color: AppColors.secondaryText,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Stack(
      children: [
        _buildActionButton(
          icon: Icons.notifications_outlined,
          label: 'Notifications',
          onTap: () {},
        ),
        Positioned(
          right: 6,
          top: 6,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.errorColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
