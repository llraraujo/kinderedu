import 'package:flutter/material.dart';
import 'package:kinderedu/components/header_component.dart';
import 'package:kinderedu/models/header_model.dart';
import '../controllers/diary_controller.dart';
import '../models/diary_model.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({Key? key}) : super(key: key);

  @override
  State<DiaryView> createState() => _DiaryYearViewState();
}

class _DiaryYearViewState extends State<DiaryView> {
  final DiaryController _controller = DiaryController();
  late List<DiaryEntry> _years;
  late ChildProfile _profile; 

  @override
  void initState() {
    super.initState();
    _years = _controller.getAvailableYears();
    _profile = _controller.getChildProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE), // Fundo levemente azulado/cinza
      body: Column(
        children: [
          header(_profile),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildTitleCard(),
                  const SizedBox(height: 25),
                  _buildYearsList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  // Card informativo superior
  Widget _buildTitleCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.description_outlined, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Relatório de Atividades', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))),
              Text('Selecione o Ano', style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  // Lista de anos para seleção
  Widget _buildYearsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _years.length,
      itemBuilder: (context, index) {
        final yearEntry = _years[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: InkWell(
            onTap: () {
              // Navegaria para a tela de timeline que criamos antes
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: yearEntry.iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(yearEntry.icon, color: yearEntry.iconColor),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    yearEntry.year,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFF2D3142)),
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}