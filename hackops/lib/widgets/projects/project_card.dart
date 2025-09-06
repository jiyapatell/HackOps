import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../screens/projects/projects_view_screen.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final VoidCallback? onTap;
  final Function(String tab)? onTabTap;

  const ProjectCard({
    super.key,
    required this.project,
    this.onTap,
    this.onTabTap,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
        _animationController.forward();
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              elevation: _isHovered ? 8 : 2,
              shadowColor: AppColors.cardShadow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: AppColors.cardGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project title
                      Text(
                        widget.project.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Project tabs
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.project.tabs.map((tab) => 
                          _buildTab(tab),
                        ).toList(),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Visual element
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.borderColor.withOpacity(0.5),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: _buildVisualElement(),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Footer with date and clicks
                      Row(
                        children: [
                          // Date
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.accentBlue,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.calendar_today,
                                  color: AppColors.primaryBlue,
                                  size: 14,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.project.date,
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          
                          const Spacer(),
                          
                          // Clicks count
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: widget.project.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              widget.project.clicks,
                              style: TextStyle(
                                color: widget.project.color,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTab(String tab) {
    return GestureDetector(
      onTap: () => widget.onTabTap?.call(tab),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Text(
          tab,
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildVisualElement() {
    switch (widget.project.visualType) {
      case ProjectVisualType.abstract:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.project.color.withOpacity(0.3),
                widget.project.color.withOpacity(0.1),
                AppColors.primaryBlue.withOpacity(0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              // Background pattern
              Positioned.fill(
                child: CustomPaint(
                  painter: _AbstractPatternPainter(widget.project.color),
                ),
              ),
              // Center icon
              const Center(
                child: Icon(
                  Icons.dashboard,
                  color: AppColors.secondaryText,
                  size: 32,
                ),
              ),
            ],
          ),
        );
      
      case ProjectVisualType.screenshot:
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
          ),
          child: Stack(
            children: [
              // Mock UI elements
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                top: 32,
                left: 16,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: widget.project.color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 64,
                child: Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 64,
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Center icon
              const Center(
                child: Icon(
                  Icons.screenshot_monitor,
                  color: AppColors.secondaryText,
                  size: 32,
                ),
              ),
            ],
          ),
        );
    }
  }
}

class _AbstractPatternPainter extends CustomPainter {
  final Color color;

  _AbstractPatternPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    // Draw abstract shapes
    final path1 = Path()
      ..moveTo(size.width * 0.2, size.height * 0.3)
      ..quadraticBezierTo(size.width * 0.4, size.height * 0.1, size.width * 0.6, size.height * 0.3)
      ..quadraticBezierTo(size.width * 0.8, size.height * 0.5, size.width * 0.6, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.4, size.height * 0.9, size.width * 0.2, size.height * 0.7)
      ..close();

    final path2 = Path()
      ..moveTo(size.width * 0.7, size.height * 0.2)
      ..quadraticBezierTo(size.width * 0.9, size.height * 0.4, size.width * 0.7, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.8, size.width * 0.3, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.1, size.height * 0.4, size.width * 0.3, size.height * 0.2)
      ..close();

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
