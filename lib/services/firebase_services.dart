import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class FirestoreService {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  User? _getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> addUser(String password, String type) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _usersCollection.doc(user.uid).set({
          'email': user.email,
          'password': password,
          'type': type,
        });
      } else {
        throw Exception('No user logged in');
      }
    } catch (e) {
      print("Error adding user: $e");
      throw e;
    }
  }

  Future<Map<String, dynamic>?> getUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userSnapshot = await _usersCollection.doc(user.uid).get();
        if (userSnapshot.exists) {
          return userSnapshot.data() as Map<String, dynamic>?;
        } else {
          return null;
        }
      } else {
        throw Exception('No user logged in');
      }
    } catch (e) {
      print("Error getting user: $e");
      throw e;
    }
  }
  Stream<List<Map<String, dynamic>>> getSellersList() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return _usersCollection.doc(user.uid).collection('data').snapshots().map((snapshot) {
          return snapshot.docs.map((doc) => doc.data()).toList();
        });
      } else {
        throw Exception('No user logged in');
      }
    } catch (e) {
      print("Error getting user: $e");
      throw e;
    }
  }


  Future<void> updateUser(Map<String, dynamic> updatedData) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _usersCollection.doc(user.uid).update(updatedData);
      } else {
        throw Exception('No user logged in');
      }
    } catch (e) {
      print("Error updating user: $e");
      throw e;
    }
  }

  Future<void> deleteUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _usersCollection.doc(user.uid).delete();
      } else {
        throw Exception('No user logged in');
      }
    } catch (e) {
      print("Error deleting user: $e");
      throw e;
    }
  }

  // Function to upload image to Firebase Storage
  Future<String> uploadImage(io.File imageFile, String imageName) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(imageName);
      final uploadTask = ref.putFile(imageFile); // Use imageFile directly
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error uploading image: $e");
      throw e;
    }
  }

  // Function to save user data along with image URL for a single user
  Future<void> saveUserDataWithImage(String password, String type, String text, io.File imageFile) async {
    try {
      final user = _getCurrentUser();
      if (user != null) {
        final String imageName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final imageURL = await uploadImage(imageFile, imageName);

        // Generate a unique document ID for the new entry
        final newEntryRef = _usersCollection.doc(user.uid).collection('data').doc();

        // Save user data along with image URL
        await newEntryRef.set({
          'text': text,
          'imageURL': imageURL,
        });

      } else {
        throw Exception('No user logged in');
      }
    } catch (e) {
      print("Error saving user data with image: $e");
      throw e;
    }
  }

  Stream<List<Map<String, dynamic>>> getBuyersList() {
    try {
      return _usersCollection.where('type', isEqualTo: 'Seller').snapshots().asyncMap((snapshot) async {
        List<Map<String, dynamic>> buyersList = [];
        for (var doc in snapshot.docs) {
          var dataSnapshot = await doc.reference.collection('data').get();
          for (var dataDoc in dataSnapshot.docs) {
            buyersList.add(dataDoc.data() as Map<String, dynamic>);
          }
        }
        return buyersList;
      });
    } catch (e) {
      print("Error getting buyers list: $e");
      throw e;
    }
  }



}
