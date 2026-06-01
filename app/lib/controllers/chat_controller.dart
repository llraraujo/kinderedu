import 'package:kinderedu/models/header_model.dart';

import '../models/chat_model.dart';

class ChatController {
  // Dados da professora
  ChatContact getContact() {
    return ChatContact(
      name: 'Profa. Carla',
      role: 'Educadora • Online',
      imageUrl: 'https://via.placeholder.com/150', // Foto da professora
      isOnline: true,
    );
  }

  ChildProfile getChildProfile() {
    return childProfileHeader;
  }

  // Histórico inicial de mensagens
  List<ChatMessage> getMessages() {
    return [
      ChatMessage(
        text: 'Bom dia! Hoje a Ana Clara está muito animada e brincando bastante com os colegas.',
        time: '09:30',
        isMe: false,
      ),
      ChatMessage(
        text: 'Que bom! Ela dormiu bem a noite toda. Obrigada pelo carinho!',
        time: '09:35',
        isMe: true,
      ),
      ChatMessage(
        text: 'Ela mamou bem e agora está fazendo a soneca da manhã. Tudo tranquilo por aqui.',
        time: '10:00',
        isMe: false,
      ),
    ];
  }
}