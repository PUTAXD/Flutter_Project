import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote_card.dart';

void main() => runApp(MaterialApp(
  home: QuoteList(),
));

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote(author: 'Socrates', text: 'The only true wisdom is in knowing you know nothing.'),
    Quote(author: 'Plato', text: 'Courage is knowing what not to fear.'),
    Quote(author: 'Aristotle', text: 'We are what we repeatedly do. Excellence, then, is not an act, but a habit.'),
    Quote(author: 'Epictetus', text: 'It’s not what happens to you, but how you react to it that matters.'),
  ];

  // Function to add a new quote
  void addQuote() {
    TextEditingController textController = TextEditingController();
    TextEditingController authorController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Quote'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(labelText: 'Quote Text'),
              ),
              TextField(
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (textController.text.isNotEmpty && authorController.text.isNotEmpty) {
                  setState(() {
                    quotes.add(Quote(
                      text: textController.text,
                      author: authorController.text,
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
  // Function to edit quote
  void editQuote(Quote quote) {
    TextEditingController textController = TextEditingController(text: quote.text);
    TextEditingController authorController = TextEditingController(text: quote.author);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Quote'),
          content: Column(
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(labelText: 'Quote Text'),
              ),
              TextField(
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  quote.text = textController.text;
                  quote.author = authorController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: quotes.map((quote) => QuoteCard(
          quote: quote,
          delete: () {
            setState(() {
              quotes.remove(quote);
            });
          },
          edit: () {
            editQuote(quote);
          }
        )).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addQuote();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
