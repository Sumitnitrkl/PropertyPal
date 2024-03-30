import 'package:flutter/material.dart';

import 'guides.dart';

class DiscussionForumPage extends StatefulWidget {
  @override
  _DiscussionForumPageState createState() => _DiscussionForumPageState();
}

class _DiscussionForumPageState extends State<DiscussionForumPage> {
  List<Map<String, String>> faqs = [
    {
      'question': 'How do I start the process of buying a property?',
      'answer': 'To begin the process of buying a property, you should first determine your budget and preferences. Then, you can start searching for properties either through our app or by contacting real estate agents. Once you find a property you\'re interested in, you can arrange viewings, conduct inspections, and negotiate with the seller before finalizing the purchase.'
    },
    {
      'question': 'What factors should I consider when choosing a property to buy?',
      'answer': 'When choosing a property to buy, it\'s important to consider factors such as location, size, layout, amenities, proximity to schools/workplaces, neighborhood safety, and future growth potential. Additionally, consider your long-term goals and whether the property meets your needs and preferences.'
    },
    {
      'question': 'How can I finance my property purchase?',
      'answer': 'There are several financing options available for property purchases, including mortgage loans, home loans, and financing through banks or financial institutions. You can discuss your financing options with lenders to determine the best option based on your financial situation, credit score, and eligibility criteria.'
    },
    {
      'question': 'What are the costs associated with buying a property?',
      'answer': 'The costs associated with buying a property typically include the purchase price, closing costs (such as legal fees, stamp duty, and registration fees), property taxes, insurance, and any additional fees charged by lenders or real estate agents. It\'s important to factor in these costs when budgeting for your property purchase.'
    },
    {
      'question': 'How do I negotiate the price of a property?',
      'answer': 'Negotiating the price of a property involves conducting research on comparable properties in the area, understanding market trends, and making a reasonable offer based on the property\'s condition and market value. You can also enlist the help of a real estate agent or negotiate directly with the seller to reach a mutually beneficial agreement.'
    },
    {
      'question': 'What are the steps involved in renting a property?',
      'answer': 'To rent a property, you should start by searching for available rental listings either through our app or through rental websites. Once you find a property you\'re interested in, you can schedule viewings, review the lease agreement, and negotiate terms with the landlord. Finally, you\'ll need to submit a rental application, undergo a background/credit check, and pay any required security deposits or upfront rent.'
    },
    {
      'question': 'What should I look for in a rental property?',
      'answer': 'When searching for a rental property, consider factors such as location, rent price, size, layout, amenities, lease terms, landlord policies, and neighborhood safety. It\'s important to choose a property that meets your needs and preferences while also fitting within your budget.'
    },
  ];


  TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussion Forum'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate to the guides/articles page
              // Replace 'GuidesPage()' with the actual page for guides/articles
              Navigator.push(context, MaterialPageRoute(builder: (_) => GuidesPage()));
            },
            child: Text('Guides/Articles'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(faqs[index]['question']!),
                  subtitle: Text(faqs[index]['answer']!),
                  onTap: () {
                    // TODO: Implement logic to navigate to the details of the selected question
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text('Your Question'),
            subtitle: TextFormField(
              controller: _questionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your question...',
              ),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                // TODO: Implement logic to submit the question to the backend
                String userQuestion = _questionController.text;
                if (userQuestion.isNotEmpty) {
                  setState(() {
                    faqs.add({'question': userQuestion, 'answer': 'Answer will be added later'});
                    _questionController.clear();
                  });
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }
}

