import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import 'trello_card_details_modal.dart';
import 'trello_board_view.dart';

class TrelloCardWidget extends StatelessWidget {
  final TrelloCard card;
  final VoidCallback? onTap;

  const TrelloCardWidget({
    super.key,
    required this.card,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderColor),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tags
              if (card.tags.isNotEmpty) ...[
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: card.tags.map((tag) => _buildTag(tag)).toList(),
                ),
                const SizedBox(height: 8),
              ],
              
              // Title
              Text(
                card.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              // Description
              if (card.description.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  card.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              
              const SizedBox(height: 12),
              
              // Footer
              Row(
                children: [
                  // Due date
                  if (_isOverdue(card.dueDate))
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.errorColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.schedule,
                            color: AppColors.errorColor,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            _formatDueDate(card.dueDate),
                            style: TextStyle(
                              color: AppColors.errorColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (_isDueSoon(card.dueDate))
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.warningColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.schedule,
                            color: AppColors.warningColor,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            _formatDueDate(card.dueDate),
                            style: TextStyle(
                              color: AppColors.warningColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  const Spacer(),
                  
                  // Assignee avatar
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: AppColors.primaryBlue,
                    child: Text(
                      card.assignee.isNotEmpty ? card.assignee[0].toUpperCase() : '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    Color backgroundColor;
    
    switch (tag.toLowerCase()) {
      case 'feedback':
        backgroundColor = AppColors.feedbackTag;
        break;
      case 'refactor':
        backgroundColor = AppColors.refactorTag;
        break;
      case 'delete':
        backgroundColor = AppColors.deleteTag;
        break;
      case 'documentation':
        backgroundColor = AppColors.infoColor;
        break;
      case 'payment':
        backgroundColor = AppColors.paymentTag;
        break;
      case 'integration':
        backgroundColor = AppColors.successColor;
        break;
      case 'cleanup':
        backgroundColor = AppColors.warningColor;
        break;
      default:
        backgroundColor = AppColors.secondaryText;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  bool _isOverdue(DateTime dueDate) {
    return dueDate.isBefore(DateTime.now());
  }

  bool _isDueSoon(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;
    return difference <= 3 && difference >= 0;
  }

  String _formatDueDate(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;
    
    if (difference < 0) {
      return 'Overdue';
    } else if (difference == 0) {
      return 'Due today';
    } else if (difference == 1) {
      return 'Due tomorrow';
    } else {
      return 'Due in $difference days';
    }
  }
}
