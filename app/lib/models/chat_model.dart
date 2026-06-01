class ChatMessage {
  final String text;
  final String time;
  final bool isMe; // Define se a mensagem é do pai (true) ou da escola (false)

  ChatMessage({
    required this.text,
    required this.time,
    required this.isMe,
  });
}

class ChatContact {
  final String name;
  final String role;
  final String imageUrl;
  final bool isOnline;

  ChatContact({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.isOnline,
  });
}