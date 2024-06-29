// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/message_tile.dart';

class SmsListScreen extends StatefulWidget {
  const SmsListScreen({super.key});

  @override
  _SmsListScreenState createState() => _SmsListScreenState();
}

class _SmsListScreenState extends State<SmsListScreen> {
  final Telephony telephony = Telephony.instance;
  List<SmsMessage> messages = [];

  @override
  void initState() {
    super.initState();
    _getSmsMessages();
  }

  _getSmsMessages() async {
    if (await Permission.sms.request().isGranted) {
      List<SmsMessage> smsList = await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.DATE_SENT],
      );
      setState(() {
        messages = smsList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Add more options
            },
          ),
        ],
      ),
      body: messages.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageTile(message: messages[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: () {
          // Add new message functionality
        },
      ),
    );
  }
}
