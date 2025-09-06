import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../sidebar/sidebar.dart';
import '../header/app_header.dart';
import '../footer/app_footer.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final String title;
  final List<String> breadcrumbs;
  final List<Widget>? actions;
  final bool showFooter;

  const MainLayout({
    super.key,
    required this.child,
    required this.title,
    this.breadcrumbs = const [],
    this.actions,
    this.showFooter = true,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool _isSidebarExpanded = true;
  bool _isMobileSidebarOpen = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Row(
            children: [
              // Desktop sidebar
              if (!isMobile)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _isSidebarExpanded ? 280 : 80,
                  decoration: const BoxDecoration(
                    color: AppColors.sidebarBackground,
                    border: Border(
                      right: BorderSide(color: AppColors.borderColor),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 8,
                        offset: Offset(2, 0),
                      ),
                    ],
                  ),
                  child: Sidebar(
                    isExpanded: _isSidebarExpanded,
                    onToggle: () {
                      setState(() {
                        _isSidebarExpanded = !_isSidebarExpanded;
                      });
                    },
                  ),
                ),
              
              // Main content area
              Expanded(
                child: Column(
                  children: [
                    // Header
                    AppHeader(
                      title: widget.title,
                      breadcrumbs: widget.breadcrumbs,
                      actions: widget.actions,
                      onMenuTap: isMobile ? () {
                        setState(() {
                          _isMobileSidebarOpen = !_isMobileSidebarOpen;
                        });
                      } : null,
                    ),
                    
                    // Content
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(isMobile ? 16 : 24),
                        child: widget.child,
                      ),
                    ),
                    
                    // Footer
                    if (widget.showFooter) const AppFooter(),
                  ],
                ),
              ),
            ],
          ),
          
          // Mobile sidebar overlay
          if (isMobile && _isMobileSidebarOpen)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 280,
                decoration: const BoxDecoration(
                  color: AppColors.sidebarBackground,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      blurRadius: 10,
                      offset: Offset(2, 0),
                    ),
                  ],
                ),
                child: Sidebar(
                  isExpanded: true,
                  onToggle: () {
                    setState(() {
                      _isMobileSidebarOpen = false;
                    });
                  },
                ),
              ),
            ),
          
          // Mobile overlay backdrop
          if (isMobile && _isMobileSidebarOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isMobileSidebarOpen = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
