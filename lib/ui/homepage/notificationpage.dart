import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NOTIFICATION'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  width: double.infinity,
                  height: 100,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
