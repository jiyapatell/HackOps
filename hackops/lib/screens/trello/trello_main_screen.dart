import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../widgets/layout/main_layout.dart';
import '../../widgets/trello/trello_board_view.dart';
import '../../widgets/navigation/trello_bottom_navigation.dart';
import '../../widgets/trello/trello_floating_action_button.dart';

class TrelloMainScreen extends StatefulWidget {
  const TrelloMainScreen({super.key});

  @override
  State<TrelloMainScreen> createState() => _TrelloMainScreenState();
}

class _TrelloMainScreenState extends State<TrelloMainScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
      floatingActionButton: isMobile ? _buildFloatingActionButton() : null,
      bottomNavigationBar: isMobile ? _buildBottomNavigation() : null,
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Header
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: AppColors.cardBackground,
            border: Border(
              bottom: BorderSide(color: AppColors.borderColor),
            ),
          ),
          child: Row(
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
                'Handy Crab',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: AppColors.secondaryText,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
        
        // Content
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              // Boards page
              const TrelloBoardView(),
              
              // Home page
              _buildHomePage(),
              
              // Notifications page
              _buildNotificationsPage(),
              
              // Profile page
              _buildProfilePage(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return MainLayout(
      title: 'Trello Board',
      breadcrumbs: ['Boards', 'Project Board'],
      showFooter: false,
      child: const TrelloBoardView(),
    );
  }

  Widget _buildHomePage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Here\'s what\'s happening with your projects',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 24),
          
          // Quick stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Active Cards',
                  value: '12',
                  icon: Icons.task_alt,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'Completed',
                  value: '8',
                  icon: Icons.check_circle,
                  color: AppColors.successColor,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Overdue',
                  value: '2',
                  icon: Icons.warning,
                  color: AppColors.errorColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'Teams',
                  value: '3',
                  icon: Icons.people,
                  color: AppColors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsPage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildNotificationItem(
                  title: 'Card "Stripe Integration" completed',
                  subtitle: '2 hours ago',
                  icon: Icons.check_circle,
                  color: AppColors.successColor,
                ),
                _buildNotificationItem(
                  title: 'Card "Remove Sales App" is overdue',
                  subtitle: '1 day ago',
                  icon: Icons.warning,
                  color: AppColors.errorColor,
                ),
                _buildNotificationItem(
                  title: 'New comment on "Optimise Website"',
                  subtitle: '3 hours ago',
                  icon: Icons.comment,
                  color: AppColors.infoColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePage() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 24),
          
          // Profile card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.primaryBlue,
                  child: const Text(
                    'TU',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Test User',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'user@mail.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildProfileStat('Cards', '20'),
                    _buildProfileStat('Boards', '3'),
                    _buildProfileStat('Teams', '2'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return TrelloBottomNavigation(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return TrelloFloatingActionButton(
      onAddCard: () {
        // Show add card dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Add Card functionality'),
            duration: Duration(seconds: 1),
          ),
        );
      },
      onAddBoard: () {
        // Show add board dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Add Board functionality'),
            duration: Duration(seconds: 1),
          ),
        );
      },
      onAddList: () {
        // Show add list dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Add List functionality'),
            duration: Duration(seconds: 1),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
