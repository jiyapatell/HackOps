import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../widgets/layout/main_layout.dart';
import '../../widgets/projects/project_card.dart';
import '../../widgets/notifications/notification_dropdown.dart';
import '../../widgets/settings/settings_modal.dart';
import '../../models/notification_model.dart';

class ProjectsViewScreen extends StatefulWidget {
  const ProjectsViewScreen({super.key});

  @override
  State<ProjectsViewScreen> createState() => _ProjectsViewScreenState();
}

class _ProjectsViewScreenState extends State<ProjectsViewScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<ProjectModel> _projects = [
    ProjectModel(
      id: '1',
      title: 'RD Services',
      tabs: ['Services', 'Customer Care'],
      date: '21/03/22',
      clicks: 'D-18 clicks',
      visualType: ProjectVisualType.abstract,
      color: AppColors.purple,
    ),
    ProjectModel(
      id: '2',
      title: 'RD Sales',
      tabs: ['Payments', 'Customer Care'],
      date: '21/03/22',
      clicks: 'E-18 clicks',
      visualType: ProjectVisualType.abstract,
      color: AppColors.primaryBlue,
    ),
    ProjectModel(
      id: '3',
      title: 'RD Upgrade',
      tabs: ['Upgrade', 'Migration'],
      date: '21/03/22',
      clicks: 'F-18 clicks',
      visualType: ProjectVisualType.screenshot,
      color: AppColors.successColor,
    ),
  ];

  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: 'Project RD Services updated',
      message: 'New features added to the project',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
    ),
    NotificationModel(
      id: '2',
      title: 'Team member joined RD Sales',
      message: 'John Doe has been added to the project',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      isRead: false,
    ),
    NotificationModel(
      id: '3',
      title: 'RD Upgrade completed',
      message: 'Migration phase has been completed',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return MainLayout(
      title: 'Projects View',
      breadcrumbs: ['Projects'],
      showFooter: false,
      actions: [
        // Search bar
        Container(
          width: isMobile ? 200 : 300,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search........',
              hintStyle: TextStyle(
                color: AppColors.lightText,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.secondaryText,
                size: 20,
              ),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Notifications
        NotificationDropdown(
          notifications: _notifications,
          onNotificationTap: (notificationId) {
            _markAsRead(notificationId);
          },
        ),
        
        const SizedBox(width: 8),
        
        // Settings
        IconButton(
          onPressed: () => _showSettingsModal(),
          icon: const Icon(
            Icons.settings,
            color: AppColors.secondaryText,
            size: 24,
          ),
        ),
      ],
      child: _buildProjectsContent(),
    );
  }

  Widget _buildProjectsContent() {
    final filteredProjects = _getFilteredProjects();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Projects header
        Row(
          children: [
            const Text(
              'Projects View',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.orange,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.grid_view,
                    color: AppColors.secondaryText,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Cards View',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Projects grid
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 768;
              final crossAxisCount = isMobile ? 1 : 3;
              
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: isMobile ? 1.5 : 1.2,
                ),
                itemCount: filteredProjects.length,
                itemBuilder: (context, index) {
                  final project = filteredProjects[index];
                  return ProjectCard(
                    project: project,
                    onTap: () => _openProject(project),
                    onTabTap: (tab) => _openProjectTab(project, tab),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  List<ProjectModel> _getFilteredProjects() {
    if (_searchController.text.isEmpty) {
      return _projects;
    }
    
    final searchTerm = _searchController.text.toLowerCase();
    return _projects.where((project) {
      return project.title.toLowerCase().contains(searchTerm) ||
             project.tabs.any((tab) => tab.toLowerCase().contains(searchTerm));
    }).toList();
  }

  void _markAsRead(String notificationId) {
    setState(() {
      final notification = _notifications.firstWhere(
        (n) => n.id == notificationId,
      );
      notification.isRead = true;
    });
  }

  void _showSettingsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SettingsModal(),
    );
  }

  void _openProject(ProjectModel project) {
    // Navigate to project details
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening project: ${project.title}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _openProjectTab(ProjectModel project, String tab) {
    // Navigate to specific project tab
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${project.title} - $tab'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class ProjectModel {
  final String id;
  final String title;
  final List<String> tabs;
  final String date;
  final String clicks;
  final ProjectVisualType visualType;
  final Color color;

  ProjectModel({
    required this.id,
    required this.title,
    required this.tabs,
    required this.date,
    required this.clicks,
    required this.visualType,
    required this.color,
  });
}

enum ProjectVisualType {
  abstract,
  screenshot,
}

