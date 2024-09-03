import 'package:flutter/material.dart';
import 'package:untitled/model/stats.dart';
import 'package:untitled/service/api_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final Future stats = ApiService().getStats();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stats',
          style: TextStyle(
            fontFamily: 'PirataOne',
            fontSize: 30.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder(
        future: stats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            Stats stats = snapshot.data;

            Widget indonesiaStatsCard = Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Overall Data in Indonesia',
                      style: TextStyle(
                        fontFamily: 'PirataOne',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    buildStatRow(
                      'Infected',
                      stats.numbers?.infected,
                    ),
                    buildStatRow(
                      'Recovered',
                      stats.numbers?.recovered,
                    ),
                    buildStatRow(
                      'Fatal',
                      stats.numbers?.fatal,
                    ),
                  ],
                ),
              ),
            );

            return ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                indonesiaStatsCard,
                const SizedBox(height: 10),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: stats.regions!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent[100],
                            child: const Icon(Icons.bar_chart,
                                color: Colors.blueAccent),
                          ),
                          title: Text(
                            '${stats.regions![index].name}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${stats.regions?[index].type}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  title: Center(
                                    child: Text(
                                      stats.regions![index].name ?? 'No Name',
                                      style: const TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildStatRow(
                                          'Infected',
                                          stats.regions?[index].numbers
                                              ?.infected),
                                      const SizedBox(height: 8.0),
                                      buildStatRow(
                                          'Recovered',
                                          stats.regions?[index].numbers
                                              ?.recovered),
                                      const SizedBox(height: 8.0),
                                      buildStatRow('Fatal',
                                          stats.regions?[index].numbers?.fatal),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }

  Widget buildStatRow(String label, int? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(
          value != null ? '$value' : 'N/A',
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        ),
      ],
    );
  }
}
