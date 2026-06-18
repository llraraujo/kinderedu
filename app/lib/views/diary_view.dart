import 'package:flutter/material.dart';
import 'package:kinderedu/components/header_component.dart';
import 'package:kinderedu/models/header_model.dart';
import 'package:kinderedu/views/diary_month_view.dart';
import '../controllers/diary_controller.dart';
import '../models/diary_model.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({Key? key, required this.cpfResponsavel}) : super(key: key);

  final String cpfResponsavel;

  @override
  State<DiaryView> createState() => _DiaryYearViewState();
}

class _DiaryYearViewState extends State<DiaryView> {
  final DiaryController _controller = DiaryController();
  late List<DiaryEntry> _years;
  ChildProfile? _profile;

  @override
  void initState() {
    super.initState();
    _years = _controller.getAvailableYears();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await _controller.getChildProfileFromDb(
      widget.cpfResponsavel,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _profile = profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = _profile;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: profile == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                header(profile),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildTitleCard(),
                        const SizedBox(height: 25),
                        _buildYearsList(profile),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTitleCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.description_outlined, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Relatorio de Atividades',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3142),
                ),
              ),
              Text(
                'Selecione o Ano',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildYearsList(ChildProfile profile) {
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiaryMonthView(
                    year: yearEntry.year,
                    profile: profile,
                    cpfResponsavel: widget.cpfResponsavel,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                  ),
                ],
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
                    yearEntry.year.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3142),
                    ),
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
