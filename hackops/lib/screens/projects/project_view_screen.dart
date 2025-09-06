import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../widgets/layout/main_layout.dart';
import '../../widgets/task/task_card.dart';

class ProjectViewScreen extends StatelessWidget {
  const ProjectViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Tasks inside a Project View',
      breadcrumbs: ['Projects', 'RD Sales'],
      actions: [
        // More options button
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.secondaryText,
            size: 24,
          ),
        ),
        
        // New Task button
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 18),
          label: const Text('New Task'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.lightBlue,
            foregroundColor: AppColors.primaryText,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
      child: _buildProjectContent(),
    );
  }

  Widget _buildProjectContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        final crossAxisCount = isMobile ? 1 : 3;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task cards grid
            Expanded(
              child: GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isMobile ? 1.5 : 1.2,
                children: [
                  TaskCard(
                    title: 'Optimise Website Controllers',
                    tags: const [
                      TaskTag(label: 'Feedback', type: TaskTagType.feedback),
                      TaskTag(label: 'Refactor', type: TaskTagType.refactor),
                    ],
                    date: '21/03/22',
                    assignee: 'John',
                    priority: TaskPriority.high,
                    status: TaskStatus.inProgress,
                    onTap: () {},
                    onMoreTap: () {},
                  ),
                  
                  TaskCard(
                    title: 'Remove Sales App 😊🤔',
                    tags: const [
                      TaskTag(label: 'Feedback', type: TaskTagType.feedback),
                      TaskTag(label: 'Delete', type: TaskTagType.delete),
                    ],
                    date: '21/03/22',
                    assignee: 'Jane',
                    priority: TaskPriority.medium,
                    status: TaskStatus.todo,
                    onTap: () {},
                    onMoreTap: () {},
                  ),
                  
                  TaskCard(
                    title: 'Stripe Integration',
                    tags: const [
                      TaskTag(label: 'Improvement', type: TaskTagType.improvement),
                      TaskTag(label: 'Payment Provider', type: TaskTagType.payment),
                    ],
                    date: '21/03/22',
                    assignee: 'Mike',
                    priority: TaskPriority.low,
                    status: TaskStatus.done,
                    onTap: () {},
                    onMoreTap: () {},
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  int _getCrossAxisCount() {
    // This would typically be determined by screen size
    // For now, return a fixed value for desktop
    return 3;
  }
}
