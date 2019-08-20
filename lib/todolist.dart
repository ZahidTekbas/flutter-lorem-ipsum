import 'package:flutter/material.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class TodoList extends StatefulWidget {
  @override
  createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  String _title;
  String _todoItems = " ";
  List<String> _previousItems = [];

  
  String generateLoremIpsum(int word){
    var sentence = lipsum.createWord(numWords: word);
    return sentence;
  }
  Widget _buildTodoList() {
    /*return ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(_todoItems[index]),
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: Icon(Icons.delete_sweep, color: Colors.white),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                _todoItems.removeAt(index);
              });
            },
            child: AnimatedContainer(
              height: 40.0,
              decoration: BoxDecoration(
                border: Border.all(width: 1.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Text(
                    _todoItems[index],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
              duration: Duration(seconds: 5),
              curve: Curves.bounceInOut,
            ),
          );
        }
      },
    );*/
    return Text(
  _todoItems,
  textAlign: TextAlign.center,
  overflow: TextOverflow.visible,
  style: TextStyle(fontWeight: FontWeight.bold),
);
  }


  Widget _noItem() {
    Widget card;
    if (_todoItems.length > 1) {
      card = _buildTodoList();
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
      body: _noItem(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushTodoScreen,
        tooltip: 'Create Ipsum',
        child: Icon(Icons.add),
        elevation: 20.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ),
    );
  }

  void _addItem(String task) {
    if (task.length > 0 || task.length == null) {
      setState(() {
        _todoItems = task;
      });
    }
  }

  void _pushTodoScreen() {
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
                _addItem(_title);
                _title = '';
                Navigator.pop(context);
              })
        ]),
      );
    }));
  }
}
