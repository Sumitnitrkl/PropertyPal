import 'package:flutter/material.dart';
import 'package:untitled4/users_type/details_page.dart';

import 'chat_bot.dart';

class SellerCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const SellerCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PropertyDetailsPage()));
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        elevation: 4, // Add elevation for a shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 16 / 9, // Aspect ratio of the image
                child: data['imageURL'] != null
                    ? Image.network(
                  data['imageURL'],
                  fit: BoxFit.cover,
                )
                    : Container(
                  color: Colors.grey, // Placeholder color if image is not available
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data['text'] ?? '', // Display text
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(buyerId: 'buyer@gamil.com', sellerId: 'seller@gmail.com',)));
                }, child: Text('Contact Buyer/Seller'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
