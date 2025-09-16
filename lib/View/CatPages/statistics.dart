import 'package:flutter/material.dart';
import 'package:virat_kohli/Themes/app_colors.dart';
import 'package:virat_kohli/Widgets/custom_back_button.dart';

class Statistics extends StatelessWidget {
  final String catName;
  const Statistics({super.key, required this.catName});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.brownishBg, AppColors.reddishBg],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 25, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.05, child: const CustomBackButton()),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    catName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const TabBar(
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "Overview"),
                    Tab(text: "Stats"),
                    Tab(text: "Records"),
                  ],
                ),

                const Expanded(
                  child: TabBarView(
                    children: [
                      OverviewTab(),
                      StatsTab(),
                      RecordsTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ----------------- OVERVIEW TAB -----------------
class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow("Full Name", "Virat Kohli"),
          _buildRow("Born", "November 05, 1988, Delhi"),
          _buildRow("Age", "36y 79d"),
          _buildRow("Batting Style", "Right hand Bat"),
          _buildRow("Bowling Style", "Right arm Medium"),
          _buildRow("Playing Role", "Top order Batter"),

          const SizedBox(height: 24),
          Text(
            "TEAMS",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 12),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _TeamTile(flag: "🇮🇳", name: "India"),
              _TeamTile(flag: "🇮🇳", name: "India A"),
              _TeamTile(flag: "🔴", name: "India Red"),
              _TeamTile(flag: "⭐", name: "North Zone"),
              _TeamTile(flag: "🌟", name: "Rest of India"),
              _TeamTile(flag: "🛡️", name: "India Emerging Players"),
              _TeamTile(flag: "🇮🇳", name: "India Under-19s"),
              _TeamTile(flag: "🕌", name: "Delhi"),
              _TeamTile(flag: "🔵", name: "India Blue"),
              _TeamTile(flag: "🏏", name: "Royal Challengers Bangalore"),
              _TeamTile(flag: "🛡️", name: "Indian Board President's XI"),
              _TeamTile(flag: "🏢", name: "Oil & Natural Gas Corporation"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

/// ----------------- STATS TAB -----------------
class StatsTab extends StatelessWidget {
  const StatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsSection("Batting Career", [
            ["Format", "Mat", "Inns", "Runs", "Avg", "100s"],
            ["Tests", "113", "191", "8848", "49.2", "29"],
            ["ODIs", "292", "280", "13848", "58.7", "50"],
            ["T20Is", "115", "107", "4008", "52.7", "1"],
            ["IPL", "237", "229", "7263", "37.2", "7"],
          ]),
          const SizedBox(height: 20),
          _buildStatsSection("Bowling Career", [
            ["Format", "Mat", "Overs", "Wkts", "Avg", "BBI"],
            ["Tests", "113", "175", "0", "-", "-"],
            ["ODIs", "292", "163", "4", "166.2", "1/15"],
            ["T20Is", "115", "41", "4", "49.2", "1/13"],
            ["IPL", "237", "41", "4", "92.0", "2/25"],
          ]),
        ],
      ),
    );
  }

  Widget _buildStatsSection(String title, List<List<String>> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Table(
            border: TableBorder.all(color: Colors.white24, width: 0.5),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
              5: FlexColumnWidth(),
            },
            children: rows
                .map((row) => TableRow(
              children: row.map((cell) {
                bool isHeader = row == rows.first;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cell,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isHeader ? Colors.amber : Colors.white,
                      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                );
              }).toList(),
            ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

/// ----------------- RECORDS TAB -----------------
class RecordsTab extends StatelessWidget {
  const RecordsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final records = [
      {"rank": "6th", "title": "Most matches as captain (68)", "subtitle": "Test matches"},
      {"rank": "7th", "title": "Most runs in a match on the losing side (256)", "subtitle": "Test matches"},
      {"rank": "🏅", "title": "Hundred in each innings of a match", "subtitle": "Test matches"},
      {"rank": "🏅", "title": "Hundred and a duck in a match", "subtitle": "Test matches"},
      {"rank": "5th", "title": "Fastest to 7000 runs (138)", "subtitle": "Test matches"},
      {"rank": "🏅", "title": "Hundred and a ninety in a match", "subtitle": "Test matches"},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Top Records",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          // List of record cards
          ...records.map((rec) => _RecordCard(
            rank: rec["rank"]!,
            title: rec["title"]!,
            subtitle: rec["subtitle"]!,
          )),
        ],
      ),
    );
  }
}

class _RecordCard extends StatelessWidget {
  final String rank;
  final String title;
  final String subtitle;

  const _RecordCard({
    required this.rank,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rank / Medal
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              rank,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 12),

          // Title + Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/// ----------------- TEAM CHIP WIDGET -----------------
class _TeamTile extends StatelessWidget {
  final String flag;
  final String name;

  const _TeamTile({required this.flag, required this.name});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Text(flag, style: const TextStyle(fontSize: 16)),
      label: Text(name,
          style: const TextStyle(color: Colors.white, fontSize: 13)),
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
