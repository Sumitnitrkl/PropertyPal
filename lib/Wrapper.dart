import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled4/users_type/buyers.dart';
import 'package:untitled4/users_type/seller.dart';

import 'authenticate/authenticate.dart';
import 'home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      // If no user is logged in, show the authentication screen
      return Authenticate();
    } else {
      // If user is logged in, fetch user data from Firestore
      return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator while fetching user data
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Show error message if unable to fetch user data
            return Text('Error: ${snapshot.error}');
          } else {
            // Get user data from snapshot
            final userData = snapshot.data!.data() as Map<String, dynamic>?;

            if (userData == null) {
              // If user data is not found, show an error message
              return Text('Error: User data not found');
            }

            // Get user type from user data
            final userType = userData['type'] as String?;

            if (userType == null) {
              // If user type is not found, show an error message
              return Text('Error: User type not found');
            }

            // Navigate user based on user type
            if (userType == 'Seller') {
              return SellerScreen(); // Navigate to seller home screen
            } else {
              return BuyerScreen(); // Navigate to buyer home screen
            }
          }
        },
      );
    }
  }
}
