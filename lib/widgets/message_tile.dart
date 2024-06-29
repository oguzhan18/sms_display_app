import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import '../screens/message_detail_screen.dart';

class MessageTile extends StatelessWidget {
  final SmsMessage message;

  const MessageTile({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(message.address ?? 'Unknown'),
      subtitle: Text(
        message.body ?? 'No Content',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        formatDate(message.dateSent),
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MessageDetailScreen(address: message.address ?? 'Unknown'),
          ),
        );
      },
    );
  }

  String formatDate(int? dateSent) {
    if (dateSent == null) return '';
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dateSent);
    return "${date.hour}:${date.minute < 10 ? '0' + date.minute.toString() : date.minute} ${date.month}/${date.day}/${date.year}";
  }
}
