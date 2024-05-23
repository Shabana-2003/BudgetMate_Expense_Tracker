import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: const Color.fromARGB(255, 47, 125, 121),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'For any questions, concerns, or feedback, feel free to reach out to our support team. We are here to assist you!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Email:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Send us an email at:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
               
              },
              child: const Text(
                'mashabana751@gmail.com',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'We strive to respond to your inquiries promptly and provide the assistance you need. Thank you for choosing BudgetMate!',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
