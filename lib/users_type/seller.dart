import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/auth.dart';
import 'package:untitled4/services/firebase_services.dart'; // Import the FirestoreService
import 'package:untitled4/users_type/seller_card.dart';
import 'image_txt_popUp.dart'; // Import the image text pop-up

class SellerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Screen'),
        actions: [
          TextButton(onPressed: (){
            AuthService().signOutTheUser();
          }, child: Text('Logout'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Propeties', // Title for the list of cards
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SellerCardsList(), // Display the list of seller cards
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the pop-up for image upload and text input
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ImageTextPopup();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class SellerCardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: firestoreService.getSellersList(), // Stream to listen for changes in seller data
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final sellerData = snapshot.data!;

        return ListView.builder(
          itemCount: sellerData.length,
          itemBuilder: (context, index) {
            final data = sellerData[index];
            return SellerCard(data: data);
          },
        );
      },
    );
  }
}


