import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  HelpScreen({
    super.key,
  });

  @override
  State<HelpScreen> createState() => _HelpScreenViewState();
}

// class _HelpScreenViewState extends State<HelpScreen> {

class _HelpScreenViewState extends State<HelpScreen> {
  // Function to handle email launch

  Future<void> sendEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'PINetworking@gmail.com',
      query:
          'subject=Help and Support&body=Describe your issue here?', //add subject and body here
    );

    // var url = params.toString();
    if (!await launchUrl(
      params,
      mode: LaunchMode.externalApplication,
      // webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
    )) {
      throw Exception('Could not launch ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        backgroundColor: const Color(0xFF857FB4),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'How can we help you?',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.person, color: const Color(0xFF857FB4)),
                title: Text('Patrick Tauma'),
                subtitle: Text('Admin'),
                trailing: IconButton(
                  icon: Icon(Icons.email, color: const Color(0xFF857FB4)),
                  onPressed: () async {
                    print("Clicked");
                    sendEmail();
                  },
                ),
              ),
            ),
            // Add more cards or information as needed
          ],
        ),
      ),
    );
  }
}
