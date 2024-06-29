// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class MessageDetailScreen extends StatelessWidget {
  final String address;

  const MessageDetailScreen({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(address),
      ),
      body: MessageDetailBody(address: address),
    );
  }
}

class MessageDetailBody extends StatefulWidget {
  final String address;

  const MessageDetailBody({super.key, required this.address});

  @override
  _MessageDetailBodyState createState() => _MessageDetailBodyState();
}

class _MessageDetailBodyState extends State<MessageDetailBody> {
  final Telephony telephony = Telephony.instance;
  List<SmsMessage> messages = [];

  @override
  void initState() {
    super.initState();
    _getConversation();
  }

  _getConversation() async {
    List<SmsMessage> smsList = await telephony.getInboxSms(
      filter: SmsFilter.where(SmsColumn.ADDRESS).equals(widget.address),
      sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.ASC)],
    );
    setState(() {
      messages = smsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return messages.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(messages[index].body ?? 'No Content'),
                subtitle: Text(formatDate(messages[index].date)),
              );
            },
          );
  }

  String formatDate(int? dateSent) {
    if (dateSent == null) return '';
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dateSent);
    return "${date.hour}:${date.minute < 10 ? '0${date.minute}' : date.minute} ${date.month}/${date.day}/${date.year}";
  }
}
