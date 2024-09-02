import 'package:flutter/material.dart';
import 'package:untitled/model/hoaxes.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, this.hoax});

  final Hoaxes? hoax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${hoax?.title}'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('${hoax?.title}'),
            Text('${hoax?.timestamp}'),
            Text('${hoax?.url}'),
          ],
        ),
      ),
    );
  }
}
