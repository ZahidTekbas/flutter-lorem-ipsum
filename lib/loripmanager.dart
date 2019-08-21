import 'package:flutter/material.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class LoremIpsumText extends StatefulWidget {
  @override
  createState() => LoremIpsumState();
}

class LoremIpsumState extends State<LoremIpsumText> {
  String _title;
  String _todoItems = " ";
  
  String generateLoremIpsum(int word){
    var sentence = lipsum.createWord(numWords: word);
    return sentence;
  }
  Widget _buildText() {
return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new SingleChildScrollView(
              child: new Text(_todoItems,
                style: new TextStyle(
                  fontSize: 16.0, color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _noText() {
    Widget card;
    if (_todoItems.length > 1) {
      card = _buildText();
    } else{
      card = Container(
        child: Center(
          child: Text('Lets generate some lorem ipsum! Click the button'),
        ),
      );
      }
    return card;
}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: _noText(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushToScreen,
        tooltip: 'Create Ipsum',
        child: Icon(Icons.add),
        elevation: 20.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ),
    );
  }

  void _addText(String task) {
    if (task.length > 0 || task.length == null) {
      setState(() {
        _todoItems = task;
      });
    }
  }

  void _pushToScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Word count for your lorem ipsum'),
        ),
        body: Column(children: [
          TextField(
            autofocus: true,
            onChanged: ( value) {
              setState(() {
                _title = value;
                int val =  int.parse(value);
                _title = generateLoremIpsum(val);
              });
            },
            decoration: InputDecoration(
                labelText: 'Words',
                contentPadding: const EdgeInsets.all(8.0)),
          ),
          RaisedButton(
              child: Text('Generate'),
              onPressed: () {
                _addText(_title);
                _title = '';
                Navigator.pop(context);
              })
        ]),
      );
    }));
  }
}
