import 'package:flutter/material.dart';
import 'package:kinderedu/components/header_component.dart';
import 'package:kinderedu/models/header_model.dart';
import 'package:kinderedu/views/diary_day_timeline.dart';
import '../controllers/diary_controller.dart';
import '../models/diary_model.dart';

class DiaryDayView extends StatefulWidget {
  final String month;
  final int year;

  const DiaryDayView({
    Key? key,
    required this.month,
    required this.year,
  }) : super(key: key);

  @override
  State<DiaryDayView> createState() => _DiaryDayViewState();
}

class _DiaryDayViewState extends State<DiaryDayView> {
  final DiaryController _controller = DiaryController();
  late ChildProfile _profile;
  late List<DiaryDayEntry> _days;

  @override
  void initState() {
    super.initState();
    _profile = _controller.getChildProfile();
    _days = _controller.getDaysForMonth(widget.month, widget.year);
  }

  int getMonth(String month){
    switch(month.trim().toUpperCase()){
      case "OUTUBRO": return 10;
      case "NOVEMBRO": return 11;
      case "DEZEMBRO": return 12;
      default: return -1;
    }    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: Column(
        children: [
          header(_profile),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildNavigationHeader(context),
                  const SizedBox(height: 20),
                  _buildDaysGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  

  // Card com seta de voltar e título do mês
  Widget _buildNavigationHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.grey),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.description_outlined, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Relatório de Atividades',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
              ),
              Text(
                '${widget.month} de ${widget.year}',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Grade de Dias
  Widget _buildDaysGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 colunas como na imagem
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85, // Ajuste para o card ser levemente vertical
      ),
      itemCount: _days.length,
      itemBuilder: (context, index) {
        final dayEntry = _days[index];
        return InkWell(
          onTap: () {
            // Aqui navegaria para a Timeline (DiaryView) do dia específico
            Navigator.push(context, MaterialPageRoute(builder: (context) => DiaryDayTimelineView(date: DateTime(widget.year, getMonth(widget.month),dayEntry.day),)));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 5)],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.description, color: Color(0xFF4ADE80), size: 28), // Ícone verde
                const SizedBox(height: 8),
                Text(
                  'Dia ${dayEntry.day}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const Text(
                  'Ver relatório',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}