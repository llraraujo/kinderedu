
import 'package:flutter/material.dart';
import 'package:kinderedu/components/header_component.dart';
import 'package:kinderedu/controllers/diary_controller.dart';
import 'package:kinderedu/models/diary_model.dart';
import 'package:kinderedu/models/header_model.dart';
import 'package:kinderedu/views/diary_day_view.dart';

class DiaryMonthView extends StatefulWidget {
  const DiaryMonthView({Key? key, required this.year, required this.profile}) : super(key: key);
  final ChildProfile profile;
  final int year;

  @override
  State<DiaryMonthView> createState() => _DiaryYearViewState();
}

class _DiaryYearViewState extends State<DiaryMonthView> {
  int _currentIndex = 0;
  final DiaryController _controller = DiaryController();
  late int _year;
  late List<DiaryMonth>_months;

@override
  void initState() {
    super.initState();
    _year = widget.year;
    _months = _controller.getAvailableMonths(_year) ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE), // Fundo levemente azulado/cinza
      body: Column(
        children: [
          header(widget.profile),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildTitleCard(),
                  const SizedBox(height: 25),
                  _buildMonthsListList(),
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
           IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.grey),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.description_outlined, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Relatório de Atividades', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))),
              Text(_year.toString(), style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonthsListList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _months.length,
      itemBuilder: (context, index) {
        final monthEntry = _months[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: InkWell(
            onTap: () {
              // Navegaria para a tela de timeline que criamos antes
              Navigator.push(context, MaterialPageRoute(builder: (context) => DiaryDayView(month: monthEntry.month, year: _year)));
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
                      color: monthEntry.iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(monthEntry.icon, color: monthEntry.iconColor),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    monthEntry.month,
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
