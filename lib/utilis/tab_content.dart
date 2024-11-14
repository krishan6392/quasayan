import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TabContent extends StatelessWidget {
  final String tabName;

  TabContent({required this.tabName});

  // Function to fetch data from a Firestore collection
  Stream<List<DocumentSnapshot>> getTabData() {
    return FirebaseFirestore.instance.collection(tabName).snapshots().map(
          (snapshot) => snapshot.docs,
        );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DocumentSnapshot>>(
      stream: getTabData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No data available"));
        }

        final data = snapshot.data!;
        return ListView(
          children: data.map((doc) {
            return ListTile(
                title: Text('Name: ${doc['Name'] ?? 'No name'}'),
                subtitle: Text('Age: ${doc['Age']?.toString() ?? 'No age'}'));
          }).toList(),
        );
      },
    );
  }
}
