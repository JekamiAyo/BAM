import 'package:bam/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //instance of auth
  final firebaseAuth = FirebaseAuth.instance;
  //insatnce of firestore
  final firestore = FirebaseFirestore.instance;


  //send message
  Future<void> sendMessage(String receiverId, String message,) async {
    //get current user ID
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final String currentUserEmail = firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    //create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );
    //create a chat room ID from both sender and receiver id (to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // sort ids (ensures that chat ID is always the same for any pair of ppl)
    String chatRoomId = ids.join("_"); //combine ids
    //add new message to db
    await firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection('messages')
        .add(
          newMessage.toMap(),
        );
  }



  //get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
