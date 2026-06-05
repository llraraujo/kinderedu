import 'package:flutter/material.dart';
import 'package:kinderedu/components/header_component.dart';
import 'package:kinderedu/models/header_model.dart';
import '../controllers/chat_controller.dart';
import '../models/chat_model.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ChatController _controller = ChatController();
  final TextEditingController _textController = TextEditingController();
  late List<ChatMessage> _messages;
  late ChatContact _contact;
  late ChildProfile _profile;

  @override
  void initState() {
    super.initState();
    _messages = _controller.getMessages();
    _contact = _controller.getContact();
    _profile = _controller.getChildProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          header(_profile), // Cabeçalho Roxo da Ana Clara
          _buildContactHeader(), // Cabeçalho da Professora
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildMessageBubble(_messages[index]),
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  

  // Cabeçalho do contato do Chat
  Widget _buildContactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1))),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(_contact.imageUrl), radius: 22),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_contact.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(_contact.role, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  // Balões de Mensagem
  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!message.isMe) ...[
                CircleAvatar(backgroundImage: NetworkImage(_contact.imageUrl), radius: 15),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: message.isMe ? const Color(0xFF7B3AED) : Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(message.isMe ? 20 : 0),
                      bottomRight: Radius.circular(message.isMe ? 0 : 20),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(color: message.isMe ? Colors.white : Colors.black87, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(message.time, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
        ],
      ),
    );
  }

  // Campo de entrada de texto
  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.1))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Digite sua mensagem...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: const BoxDecoration(color: Color(0xFF9D4EDD), shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
              onPressed: () {
                // Lógica de envio seria implementada no controller
              },
            ),
          ),
        ],
      ),
    );
  }
}