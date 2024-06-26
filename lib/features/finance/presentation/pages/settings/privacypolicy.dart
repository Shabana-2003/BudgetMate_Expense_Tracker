import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: const Color.fromARGB(255, 47, 125, 121),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Last Updated: December 30, 2023',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Welcome to BudgetMate, your personal money manager application! This Privacy Policy outlines how Financia collects, uses, and protects your personal information. By using BudgetMate, you agree to the terms outlined in this policy.',
            ),
            const SizedBox(height: 16),
            _buildPrivacyPolicyItem(
              'Information We Collect',
              'Financial Data: BudgetMate collects and stores the financial data you input into the application, including income, expenses, and related details.',
            ),
            _buildPrivacyPolicyItem(
              'How We Use Your Information',
              'Internal Use: We use your financial data to provide personalized financial insights and management tools within the application.',
            ),
            _buildPrivacyPolicyItem(
              'Data Security',
              'Encryption: BudgetMate employs industry-standard encryption and security measures to protect your financial data from unauthorized access.',
            ),
            _buildPrivacyPolicyItem(
              'Data Sharing',
              'Third Parties: BudgetMate does not share your personal financial data with third parties.',
            ),
            _buildPrivacyPolicyItem(
              'Application Updates',
              'Updates: Periodic updates may be released to enhance features and security. Ensure your app is always up-to-date.',
            ),
            _buildPrivacyPolicyItem(
              'Privacy Policy Changes',
              'Updates: We reserve the right to update or modify this privacy policy at any time. Check this page periodically for changes.',
            ),
            _buildPrivacyPolicyItem(
              'User Responsibilities',
              'Data Accuracy: Users are responsible for the accuracy and security of their financial data within the application.',
            ),
            _buildPrivacyPolicyItem(
              'Contact Us',
              'Support: For any questions or concerns regarding this Privacy Policy, contact our support team.',
            ),
            _buildPrivacyPolicyItem(
              'Disclaimer',
              'No Guarantees: Financia is provided "as is" without any guarantees. We are not liable for any financial decisions made based on the information provided by the application.',
            ),
            const SizedBox(height: 16),
            const Text(
              'By using BudgetMate, you acknowledge that you have read, understood, and agree to this Privacy Policy.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyPolicyItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(content),
      ],
    );
  }
}
