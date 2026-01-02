import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/keep_drawer.dart';

class DeletedScreen extends StatefulWidget {
  const DeletedScreen({super.key});

  @override
  State<DeletedScreen> createState() => _DeletedScreenState();
}

class _DeletedScreenState extends State<DeletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(onPressed: () {
                Scaffold.of(context).openDrawer();
              }, icon: Icon(Icons.menu)),
            );
          }
        ),
        title: Text('Deleted'),
      ),
      drawer: KeepDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.delete, size: 150, color: Colors.amber,),
            Text(
              'No Notes in Recycle Bin',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
