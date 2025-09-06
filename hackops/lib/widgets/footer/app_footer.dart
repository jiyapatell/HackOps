import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24, 
        vertical: isMobile ? 16 : 20,
      ),
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          top: BorderSide(color: AppColors.borderColor),
        ),
      ),
      child: isMobile ? _buildMobileFooter() : _buildDesktopFooter(),
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company info
        Row(
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
                Icons.bug_report,
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
          ],
        ),
        
        const SizedBox(height: 12),
        
        const Text(
          'Streamline your project management with our intuitive platform.',
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 14,
            height: 1.4,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Social media icons
        Row(
          children: [
            _buildSocialIcon(Icons.facebook, 'Facebook'),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.alternate_email, 'Twitter'),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.link, 'LinkedIn'),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.code, 'GitHub'),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Quick links section
        _buildMobileSection(
          title: 'Quick Links',
          items: ['Dashboard', 'Projects', 'Tasks', 'Team', 'Analytics'],
        ),
        
        const SizedBox(height: 20),
        
        // Support section
        _buildMobileSection(
          title: 'Support',
          items: ['Help Center', 'Documentation', 'Contact Us', 'Status Page'],
        ),
        
        const SizedBox(height: 20),
        
        // Company section
        _buildMobileSection(
          title: 'Company',
          items: ['About Us', 'Careers', 'Privacy Policy', 'Terms of Service'],
        ),
        
        const SizedBox(height: 24),
        
        // Bottom bar
        Container(
          padding: const EdgeInsets.only(top: 16),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.dividerColor),
            ),
          ),
          child: Column(
            children: [
              const Text(
                '© 2024 Handy Crab. All rights reserved.',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.successColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'All systems operational',
                      style: TextStyle(
                        color: AppColors.successColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopFooter() {
    return Column(
      children: [
        // Main footer content
        Row(
          children: [
            // Company info
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                          Icons.bug_report,
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
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Streamline your project management with our intuitive platform. Built for teams who value efficiency and collaboration.',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildSocialIcon(Icons.facebook, 'Facebook'),
                      const SizedBox(width: 12),
                      _buildSocialIcon(Icons.alternate_email, 'Twitter'),
                      const SizedBox(width: 12),
                      _buildSocialIcon(Icons.link, 'LinkedIn'),
                      const SizedBox(width: 12),
                      _buildSocialIcon(Icons.code, 'GitHub'),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 40),
            
            // Quick links
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Links',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFooterLink('Dashboard'),
                  _buildFooterLink('Projects'),
                  _buildFooterLink('Tasks'),
                  _buildFooterLink('Team'),
                  _buildFooterLink('Analytics'),
                ],
              ),
            ),
            
            const SizedBox(width: 40),
            
            // Support
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Support',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFooterLink('Help Center'),
                  _buildFooterLink('Documentation'),
                  _buildFooterLink('Contact Us'),
                  _buildFooterLink('Status Page'),
                  _buildFooterLink('Community'),
                ],
              ),
            ),
            
            const SizedBox(width: 40),
            
            // Company
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Company',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFooterLink('About Us'),
                  _buildFooterLink('Careers'),
                  _buildFooterLink('Privacy Policy'),
                  _buildFooterLink('Terms of Service'),
                  _buildFooterLink('Security'),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Bottom bar
        Container(
          padding: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.dividerColor),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '© 2024 Handy Crab. All rights reserved.',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.successColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'All systems operational',
                          style: TextStyle(
                            color: AppColors.successColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileSection({
    required String title,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: items.map((item) => _buildFooterLink(item)).toList(),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
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
          size: 16,
        ),
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
