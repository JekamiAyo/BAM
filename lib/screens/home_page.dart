import 'package:bam/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firebaseAuth = FirebaseAuth.instance;
  final authservice = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              authservice.signOut();
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("loading..."));
          }
          return ListView(
            children: snapshot.data!.docs.map<Widget>((doc) {
              return _buildListUserItem(doc);
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildListUserItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display all users except current user
    if (firebaseAuth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['fullName']),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatPage(
                  receiveUserName: data['fullName'],
                  receiveUserUID: data['uid'],
                );
              },
            ),
          );
        },
      );
    }
    return Container();
  }
}
