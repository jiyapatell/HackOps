import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import 'trello_card_widget.dart';
import 'trello_card_details_modal.dart';
import 'add_card_dialog.dart';

class TrelloBoardView extends StatefulWidget {
  const TrelloBoardView({super.key});

  @override
  State<TrelloBoardView> createState() => _TrelloBoardViewState();
}

class _TrelloBoardViewState extends State<TrelloBoardView> {
  final List<TrelloColumn> _columns = [
    TrelloColumn(
      id: 'todo',
      title: 'To Do',
      color: AppColors.lightText,
      cards: [
        TrelloCard(
          id: '1',
          title: 'Optimise Website Controllers',
          description: 'Improve performance and code quality',
          tags: ['Feedback', 'Refactor'],
          assignee: 'John',
          dueDate: DateTime.now().add(const Duration(days: 3)),
        ),
        TrelloCard(
          id: '2',
          title: 'Update Documentation',
          description: 'Update API documentation for new features',
          tags: ['Documentation'],
          assignee: 'Jane',
          dueDate: DateTime.now().add(const Duration(days: 5)),
        ),
      ],
    ),
    TrelloColumn(
      id: 'inprogress',
      title: 'In Progress',
      color: AppColors.warningColor,
      cards: [
        TrelloCard(
          id: '3',
          title: 'Remove Sales App',
          description: 'Remove deprecated sales application',
          tags: ['Delete', 'Cleanup'],
          assignee: 'Mike',
          dueDate: DateTime.now().add(const Duration(days: 1)),
        ),
      ],
    ),
    TrelloColumn(
      id: 'done',
      title: 'Done',
      color: AppColors.successColor,
      cards: [
        TrelloCard(
          id: '4',
          title: 'Stripe Integration',
          description: 'Complete payment integration',
          tags: ['Payment', 'Integration'],
          assignee: 'Sarah',
          dueDate: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Board header
          _buildBoardHeader(),
          
          const SizedBox(height: 16),
          
          // Board columns
          Expanded(
            child: isMobile ? _buildMobileBoard() : _buildDesktopBoard(),
          ),
        ],
      ),
    );
  }

  Widget _buildBoardHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.primaryGradient,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.dashboard,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Project Board',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
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
                Icons.visibility,
                color: AppColors.secondaryText,
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                'Board View',
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
    );
  }

  Widget _buildMobileBoard() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _columns.length,
      itemBuilder: (context, index) {
        final column = _columns[index];
        return Container(
          width: 280,
          margin: const EdgeInsets.only(right: 16),
          child: _buildColumn(column),
        );
      },
    );
  }

  Widget _buildDesktopBoard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _columns.map((column) => 
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            child: _buildColumn(column),
          ),
        ),
      ).toList(),
    );
  }

  Widget _buildColumn(TrelloColumn column) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: column.color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: column.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  column.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: column.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${column.cards.length}',
                    style: TextStyle(
                      color: column.color,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: column.cards.length + 1, // +1 for add card button
              itemBuilder: (context, index) {
                if (index == column.cards.length) {
                  return _buildAddCardButton(column);
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TrelloCardWidget(
                    card: column.cards[index],
                    onTap: () => _showCardDetails(column.cards[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardButton(TrelloColumn column) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showAddCardDialog(column),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.borderColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.borderColor,
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.add,
                  color: AppColors.secondaryText,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  'Add a card',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCardDetails(TrelloCard card) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TrelloCardDetailsModal(card: card),
    );
  }

  void _showAddCardDialog(TrelloColumn column) {
    showDialog(
      context: context,
      builder: (context) => AddCardDialog(
        column: column,
        onAdd: (title, description) {
          setState(() {
            column.cards.add(TrelloCard(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: title,
              description: description,
              tags: [],
              assignee: 'You',
              dueDate: DateTime.now().add(const Duration(days: 7)),
            ));
          });
        },
      ),
    );
  }
}

class TrelloColumn {
  final String id;
  final String title;
  final Color color;
  final List<TrelloCard> cards;

  TrelloColumn({
    required this.id,
    required this.title,
    required this.color,
    required this.cards,
  });
}

class TrelloCard {
  final String id;
  final String title;
  final String description;
  final List<String> tags;
  final String assignee;
  final DateTime dueDate;

  TrelloCard({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.assignee,
    required this.dueDate,
  });
}
