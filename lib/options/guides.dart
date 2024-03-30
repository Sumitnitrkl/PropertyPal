import 'package:flutter/material.dart';

class GuidesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guides/Articles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GuideStep(
                title: 'How to Enlist Properties:',
                steps: [
                  '1. **Sign In:** Log in to your *Property Pal* account using your registered email address and password.',
                  '2. **Navigate to Dashboard:** Once logged in, navigate to the dashboard section of your account.',
                  '3. **Click on "Enlist Property":** Look for the option to enlist a property, usually found in the sidebar or main menu.',
                  '4. **Fill in Property Details:** Provide all necessary details about the property, including its type (apartment, hotel, etc.), location, size, amenities, and images.',
                  '5. **Set Pricing:** Set the pricing details for the property, including rent or sale price, and any additional charges or fees.',
                  '6. **Review and Submit:** Double-check all the information provided, ensuring accuracy and completeness. Once satisfied, submit the property listing for review.',
                ],
              ),
              SizedBox(height: 20),
              GuideStep(
                title: 'How to Buy Properties:',
                steps: [
                  '1. **Search for Properties:** Use the search feature on the *Property Pal* app to find properties that match your criteria. You can search by location, price range, size, and other preferences.',
                  '2. **Explore Property Listings:** Browse through the available property listings to find properties that interest you. View detailed information, photos, and virtual tours to get a better understanding of each property.',
                  '3. **Contact Property Owner/Agent:** If you find a property you\'re interested in, reach out to the property owner or agent through the contact information provided in the listing. You can inquire about additional details, schedule a viewing, or negotiate terms.',
                  '4. **Schedule Viewing:** Arrange a viewing of the property to see it in person and assess its suitability for your needs.',
                  '5. **Negotiate Terms:** Discuss and negotiate terms of the sale with the property owner or agent. This may include price, payment terms, and any other conditions.',
                  '6. **Complete Transaction:** Once terms are agreed upon, proceed to complete the transaction according to the agreed-upon terms. This may involve signing contracts, making payments, and transferring ownership.',
                ],
              ),
              SizedBox(height: 20),
              GuideStep(
                title: 'How to Rent Properties:',
                steps: [
                  '1. **Search for Rental Properties:** Use the search feature on the *Property Pal* app to find rental properties that match your criteria. You can search by location, price range, size, and other preferences.',
                  '2. **Explore Rental Listings:** Browse through the available rental listings to find properties that suit your needs. View detailed information, photos, and virtual tours to assess each property.',
                  '3. **Contact Property Owner/Agent:** If you find a rental property you\'re interested in, contact the property owner or agent through the provided contact information. Inquire about rental terms, availability, and any other relevant details.',
                  '4. **Schedule Viewing:** Arrange a viewing of the rental property to inspect it in person and determine if it meets your requirements.',
                  '5. **Submit Rental Application:** If you decide to proceed with renting the property, submit a rental application as per the instructions provided by the property owner or agent. Include any required documentation and information.',
                  '6. **Sign Lease Agreement:** Once your rental application is approved, sign the lease agreement outlining the terms and conditions of the rental arrangement.',
                  '7. **Move-in:** After signing the lease agreement and completing any required payments (e.g., security deposit, first month\'s rent), you can move into the rental property and begin your tenancy.',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GuideStep extends StatelessWidget {
  final String title;
  final List<String> steps;

  const GuideStep({required this.title, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: steps
              .map(
                (step) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                step,
                style: TextStyle(height: 1.5),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}
