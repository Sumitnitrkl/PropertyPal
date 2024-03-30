import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Big Image
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/5.jpg'), // Placeholder URL for big image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Large amount of text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Price-4.5Cr For sale: A chic 2-room apartment in Clichy\'s premier location, perched on the top floor for stunning open views. This stylish abode features a spacious living area, comfortable bedroom, and modern kitchen. Sunlight floods the space through large windows, enhancing its airy feel. Step onto the balcony to enjoy panoramic cityscapes. Conveniently located near amenities and transportation, this Clichy gem offers an urban retreat with cosmopolitan flair. Ideal for investors or those seeking a fashionable city home.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            // Grid of images
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              physics: NeverScrollableScrollPhysics(),
              children: [
                 Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/1.jpg') ,// Placeholder URL for grid images
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/2.jpg') ,// Placeholder URL for grid images
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/3.jpg') ,// Placeholder URL for grid images
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/4.jpg') ,// Placeholder URL for grid images
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/6.jpg') ,// Placeholder URL for grid images
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/7.jpg') ,// Placeholder URL for grid images
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
             ]
            ),
            SizedBox(height: 20),
            // Rating bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                onPressed: () {
                  // Add your logic to launch the URL
                  _launchUrl('https://tour.klapty.com/dDY0h4zg5S/?deeplinking=true&startscene=1&startactions=lookat(57.05,-0.46,90,0,0);');
                },
                child: Text('Live View'),
              ),
            ),
            CustomRatingBar(),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch the view');
    }
  }
}

class CustomRatingBar extends StatefulWidget {
  @override
  _CustomRatingBarState createState() => _CustomRatingBarState();
}

class _CustomRatingBarState extends State<CustomRatingBar> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(38.0),
      child: Row(
        children: [
          Text('Rate this property: '),
          SizedBox(width: 10),
          RatingBar.builder(
            initialRating: _rating,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 30,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
        ],
      ),
    );
  }
}
