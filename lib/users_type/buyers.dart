import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/auth.dart';
import 'package:untitled4/users_type/seller.dart';

import '../services/firebase_services.dart';

class BuyerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Buyers Screen'),
        actions: [
          TextButton(onPressed: (){
            AuthService().signOutTheUser();
          }, child: Text('Logout'))
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: firestoreService.getBuyersList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final sellersList = snapshot.data!;

          return ListView.builder(
            itemCount: sellersList.length,
            itemBuilder: (context, index) {
              final sellerData = sellersList[index];
              return SellerCard(data: sellerData);
            },
          );
        },
      ),
    );
  }
}

