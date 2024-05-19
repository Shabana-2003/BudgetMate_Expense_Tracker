
import 'package:budgetmate/features/money_management/data/auth/auth_services.dart';
import 'package:budgetmate/features/money_management/presentation/pages/settings/contactus.dart';
import 'package:budgetmate/features/money_management/presentation/pages/settings/faq.dart';
import 'package:budgetmate/features/money_management/presentation/pages/settings/instructionalcontent.dart';
import 'package:budgetmate/features/money_management/presentation/pages/settings/privacypolicy.dart';
import 'package:budgetmate/features/money_management/presentation/pages/settings/termsofusescreen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {

  final auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor:Color.fromARGB(255, 47, 125, 121),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSettingsItem(
            'Terms of Use',
            'View and agree to the Terms of Use',
            () {
              _navigateToTermsOfUse(context);
            },
          ),
          _buildSettingsItem(
            'Privacy Policy',
            'Read our Privacy Policy',
            () {
              _navigateToPrivacyPolicy(context);
            },
          ),
          _buildSettingsItem(
            'Instructional Content',
            'Learn how to use the app',
            () {
              _navigateToInstructionalContent(context);
            },
          ),
          _buildSettingsItem(
            'Frequently Asked Questions (FAQs)',
            'Get answers to common questions',
            () {
              _navigateToFAQs(context);
            },
          ),
          _buildSettingsItem(
            'Contact Us',
            'Reach out for support or feedback',
            () {
              _navigateToContactUs(context);
            },
          ),
          _buildSettingsItem(
            'Sign Out',
            'Sign Out from the app',
            () {
              _showVersionInfo(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String title, String subtitle, VoidCallback onTap) {
  return Column(
    children: [
      ListTile(
        contentPadding: EdgeInsets.only(left: 5, right: 10), // Adjust left and right padding
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Color.fromARGB(255, 168, 168, 168)), // Lighten the subtitle text
        ),
        onTap: onTap,
      ),   
    ],
  );
}



  void _navigateToTermsOfUse(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => TermsOfUseScreen()));
  }

  void _navigateToPrivacyPolicy(BuildContext context) {
   Navigator.push(context, MaterialPageRoute(builder: (_) => PrivacyPolicyScreen()));
  }

  void _navigateToInstructionalContent(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => InstructionalContentScreen()));
  }

  void _navigateToFAQs(BuildContext context) {
   Navigator.push(context, MaterialPageRoute(builder: (_) => FAQsScreen()));
  }

  void _navigateToContactUs(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => ContactUsScreen()));
  }

  void _showVersionInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete",
              style: TextStyle(color: Color.fromARGB(255, 249, 248, 248))),
          backgroundColor: Color.fromARGB(255, 2, 116, 106),
          content: Text(
            "Are you sure you want to delete this transaction?",
            style: TextStyle(color: Color.fromARGB(255, 206, 199, 199)),
          ),
          
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text("Cancel",
                      style: TextStyle(color: Color.fromARGB(255, 194, 187, 187))),
                ),
                
              TextButton(
              onPressed: () async {
                await auth.signout();
              },
               child: Text("Sign Out",
                      style: TextStyle(color: Color.fromARGB(255, 194, 187, 187))),
                ),
           
              ],
            ),
             
          ],
        );
      },
    );
  }
   
}
