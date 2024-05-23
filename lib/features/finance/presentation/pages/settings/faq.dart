import 'package:flutter/material.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions (FAQs)'),
        backgroundColor:const Color.fromARGB(255, 47, 125, 121),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFAQItem(
              'What is BudgetMate, and how does it work?',
              'BudgetMate is a personal money management application that helps you track your income and expenses. It allows you to input your financial data, view insightful charts, and gain a better understanding of your spending habits.',
            ),
            _buildFAQItem(
              'Is BudgetMate free to use?',
              'Yes, BudgetMate is free to download and use. There are no subscription fees or hidden charges.',
            ),
            _buildFAQItem(
              'How do I add my income and expenses to BudgetMate?',
              'To add an income or expense, go to the "Add" page, choose the category, enter the amount, and provide additional details if needed. Save the entry to update your financial records.',
            ),
            _buildFAQItem(
              'Can I edit or delete entries?',
              'Yes, you can edit or delete entries. Navigate to the "Records" page, tap on the entry you want to modify, and select the appropriate option.',
            ),
            _buildFAQItem(
              'How secure is my financial data in Financia?',
              'BudgetMate uses industry-standard encryption and security measures to protect your financial data. Your data is stored securely, and access is restricted to ensure confidentiality.',
            ),
            _buildFAQItem(
              'Are there different views to analyze my financial data?',
              'Yes, BudgetMate provides weekly, monthly, daily, and yearly views. Navigate to these pages to get a detailed breakdown of your financial activities for different time frames.',
            ),
            _buildFAQItem(
              'Can I customize my app experience?',
              'Yes, you can customize your app experience on the "Profile" page. Adjust your nickname and explore optional settings to tailor the app to your preferences.',
            ),
            _buildFAQItem(
              'How do I contact support if I have issues or feedback?',
              'For any assistance or feedback, you can contact our support team through the app. Visit the "Profile" or "Settings" page for support options.',
            ),
            _buildFAQItem(
              'Is my financial information shared with third parties?',
              'No, Financia does not share your personal financial data with third parties. Your data is treated with the utmost privacy and confidentiality.',
            ),
            _buildFAQItem(
              'What happens if I forget my password?',
              'BudgetMate does not require a password since it doesn\'t have user accounts. You don\'t need to worry about forgetting a password.',
            ),
            _buildFAQItem(
              'How often should I update the app?',
              'It\'s recommended to update the app regularly to benefit from the latest features and security enhancements. Check for updates in your device\'s app store.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(answer),
      ],
    );
  }
}
