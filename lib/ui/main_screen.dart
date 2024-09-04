import 'package:flutter/material.dart';
import 'package:untitled/model/hoaxes.dart';
import 'package:untitled/service/api_service.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(
      {super.key, this.username, this.password, this.firstName, this.lastName});

  final String? username;
  final String? password;
  final String? firstName;
  final String? lastName;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Future<List<Hoaxes>?> hoaxes = ApiService().getHoaxes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Covid-19 Info',
          style: TextStyle(
            fontFamily: 'PirataOne',
            fontSize: 40.0,
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildCompactProfile(),
            const Divider(height: 10.0),
            Expanded(
              child: FutureBuilder<List<Hoaxes>?>(
                future: hoaxes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No hoaxes found'),
                    );
                  } else {
                    return _buildHoaxesList(snapshot.data!);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  Widget _buildCompactProfile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 50.0,
          backgroundColor: Colors.grey[200],
          child: const Icon(
            Icons.person,
            size: 50.0,
            color: Colors.lightGreen,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${widget.username ?? "User"}!',
                style: const TextStyle(
                  fontFamily: 'PirataOne',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              _buildUserInfo('First Name', widget.firstName),
              _buildUserInfo('Last Name', widget.lastName),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        '$label: ${value ?? "N/A"}',
        style: const TextStyle(
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.lightGreen,
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                Icons.local_hospital,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/hospitals');
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.article,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/news');
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.bar_chart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/stats');
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoaxesList(List<Hoaxes> hoaxes) {
    return ListView.builder(
      itemCount: hoaxes.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            title: Text(
              '${hoaxes[index].title}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(
                  hoaxes[index].timestamp ?? 0,
                ),
              ),
              style: TextStyle(fontFamily: 'Oswald'),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('${hoaxes[index].title}'),
                    content: Text(
                      '${hoaxes[index].url}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
