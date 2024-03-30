import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/auth.dart';
import 'package:untitled4/options/discussions_Forum.dart';
import 'package:untitled4/users_type/seller.dart';
import 'package:untitled4/users_type/seller_card.dart';

import '../options/maintainance.dart';
import '../services/firebase_services.dart';

class BuyerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Buyers Screen'),
        actions: [
          TextButton(
            onPressed: () {
              AuthService().signOutTheUser();
            },
            child: Text('Logout'),
          )
        ],
      ),
      drawer: DrawerWidget(),
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

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Buy a Property'),
            onTap: () {
              // Navigate to buy a property screen
            },
          ),
          ListTile(
            title: Text('Maintenance'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MaintenancePage()));
              // Navigate to maintenance screen
            },
          ),

          ListTile(
            title: Text('Discussions Forum'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DiscussionForumPage()));
              // Navigate to discussions forum screen
            },
          ),
        ],
      ),
    );
  }
}
