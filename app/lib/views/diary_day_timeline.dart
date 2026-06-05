import 'package:flutter/material.dart';
import 'package:kinderedu/components/header_component.dart';
import 'package:kinderedu/models/header_model.dart';
import '../controllers/diary_controller.dart';
import '../models/diary_model.dart';

class DiaryDayTimelineView extends StatefulWidget {
  final DateTime date;
  const DiaryDayTimelineView({Key? key, required this.date}) : super(key: key);

  @override
  State<DiaryDayTimelineView> createState() => _DiaryDayTimelineViewState();
}

class _DiaryDayTimelineViewState extends State<DiaryDayTimelineView> {
  final DiaryController _controller = DiaryController();
  late ChildProfile _profile;
  late List<DayActivity> _activities;

  @override
  void initState() {
    super.initState();
    _profile = _controller.getChildProfile();
    _activities = _controller.getActivitiesForDay(widget.date);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNavigationHeader(context),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      'Atividades do Dia',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTimeline(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  String getMonth(int month){
    switch(month){
      case 10: return "Outubro";
      case 11: return "Novembro";
      case 12: return "Dezembro";
      default: return "";
    }    
  }


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
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.description_outlined, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Relatório de Atividades', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))),
              Text('${widget.date.day} de ${getMonth(widget.date.month)} de ${widget.date.year}', style: TextStyle(fontSize: 13, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _activities.length,
      itemBuilder: (context, index) {
        final activity = _activities[index];
        return IntrinsicHeight(
          child: Row(
            children: [
              // Linha e Ícone
              Column(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: activity.color, shape: BoxShape.circle),
                    child: Icon(activity.icon, color: Colors.white, size: 20),
                  ),
                  Expanded(
                    child: Container(
                      width: 2,
                      color: index == _activities.length - 1 ? Colors.transparent : Colors.grey.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              // Conteúdo
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(activity.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))),
                          const SizedBox(height: 4),
                          Text(activity.description, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                        ],
                      ),
                      Text(activity.time, style: TextStyle(fontSize: 13, color: Colors.grey[500], fontWeight: FontWeight.w500)),
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