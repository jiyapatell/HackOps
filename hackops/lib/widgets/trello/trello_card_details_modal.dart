import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import 'trello_board_view.dart';

class TrelloCardDetailsModal extends StatefulWidget {
  final TrelloCard card;

  const TrelloCardDetailsModal({
    super.key,
    required this.card,
  });

  @override
  State<TrelloCardDetailsModal> createState() => _TrelloCardDetailsModalState();
}

class _TrelloCardDetailsModalState extends State<TrelloCardDetailsModal> {
  final List<CardComment> _comments = [
    CardComment(
      id: '1',
      author: 'John',
      content: 'This looks good to me!',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    CardComment(
      id: '2',
      author: 'Jane',
      content: 'I\'ll review this by tomorrow.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.borderColor),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.secondaryText,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.archive_outlined,
                    color: AppColors.secondaryText,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card title
                  Text(
                    widget.card.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Tags
                  if (widget.card.tags.isNotEmpty) ...[
                    const Text(
                      'Labels',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.card.tags.map((tag) => _buildTag(tag)).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                  
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: Text(
                      widget.card.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryText,
                        height: 1.4,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Due date
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        color: AppColors.secondaryText,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Due Date',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _isOverdue(widget.card.dueDate) 
                              ? AppColors.errorColor.withOpacity(0.1)
                              : AppColors.successColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _formatDueDate(widget.card.dueDate),
                          style: TextStyle(
                            color: _isOverdue(widget.card.dueDate) 
                                ? AppColors.errorColor
                                : AppColors.successColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Assignee
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: AppColors.secondaryText,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Assigned to',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: AppColors.primaryBlue,
                        child: Text(
                          widget.card.assignee.isNotEmpty 
                              ? widget.card.assignee[0].toUpperCase() 
                              : '?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.card.assignee,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Comments section
                  const Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Add comment
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.primaryBlue,
                          child: const Text(
                            'Y',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Write a comment...',
                              hintStyle: TextStyle(
                                color: AppColors.lightText,
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (value) {
                              if (value.trim().isNotEmpty) {
                                setState(() {
                                  _comments.add(CardComment(
                                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                                    author: 'You',
                                    content: value.trim(),
                                    timestamp: DateTime.now(),
                                  ));
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Comments list
                  ..._comments.map((comment) => _buildComment(comment)).toList(),
                ],
              ),
            ),
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildComment(CardComment comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primaryBlue,
            child: Text(
              comment.author.isNotEmpty ? comment.author[0].toUpperCase() : '?',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.author,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatTimestamp(comment.timestamp),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.lightText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment.content,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryText,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isOverdue(DateTime dueDate) {
    return dueDate.isBefore(DateTime.now());
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

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

class CardComment {
  final String id;
  final String author;
  final String content;
  final DateTime timestamp;

  CardComment({
    required this.id,
    required this.author,
    required this.content,
    required this.timestamp,
  });
}
