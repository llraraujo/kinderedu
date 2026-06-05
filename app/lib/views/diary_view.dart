import 'package:flutter/material.dart';
import 'package:kinderedu/components/header_component.dart';
import 'package:kinderedu/models/header_model.dart';
import '../controllers/diary_controller.dart';
import '../models/diary_model.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({Key? key}) : super(key: key);

  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {
  final DiaryController _controller = DiaryController();
  late List<DiaryEntry> _entries;
  late ChildProfile _profile;

  @override
  void initState() {
    super.initState();
    _entries = _controller.getDiaryEntries();
    _profile = _controller.getChildProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          header(_profile), // Reutilizando a lógica do Dashboard
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Column(
                children: [
                  _buildDateSelector(),
                  const SizedBox(height: 25),
                  _buildTimelineHeader(),
                  const SizedBox(height: 20),
                  _buildTimelineList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  // Card de seleção de data
  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.calendar_month, color: Color(0xFF7B3AED)),
          ),
          const SizedBox(width: 15),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Diário de Atividades', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))),
              Text('27 de Novembro, 2025', style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineHeader() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Atividades de Hoje',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
      ),
    );
  }

  // Construção da Timeline
  Widget _buildTimelineList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _entries.length,
      itemBuilder: (context, index) {
        final entry = _entries[index];
        return IntrinsicHeight(
          child: Row(
            children: [
              // Coluna da Esquerda: Ícone e Linha Conectora
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: entry.color, shape: BoxShape.circle),
                    child: Icon(entry.icon, color: Colors.white, size: 20),
                  ),
                  Expanded(
                    child: Container(
                      width: 2,
                      color: index == _entries.length - 1 ? Colors.transparent : Colors.grey.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              // Coluna da Direita: Conteúdo
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.title,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              entry.description,
                              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        entry.time,
                        style: TextStyle(fontSize: 13, color: Colors.grey[500], fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}