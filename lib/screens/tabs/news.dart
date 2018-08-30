import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../common_widgets/counter_list_tile.dart';
import '../../common_widgets/list_items_builder.dart';
import '../../models/counter.dart';
import '../../data/database.dart';

class NewsPage extends StatelessWidget {
  NewsPage({this.database});
  final Database database;

  void _createCounter() async {
    await database.createCounter();
  }

  void _increment(Counter counter) async {
    counter.value++;
    await database.setCounter(counter);
  }

  void _decrement(Counter counter) async {
    counter.value--;
    await database.setCounter(counter);
  }

  void _delete(Counter counter) async {
    await database.deleteCounter(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        elevation: 1.0,
      ),
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _createCounter,
      ),
    );
  }

  Widget _buildContent() {
    return ScopedModelDescendant<CountersModel>(
        builder: (context, child, model) {
      return ListItemsBuilder<Counter>(
          items: model.counters,
          itemBuilder: (context, counter) {
            return CounterListTile(
              key: Key('counter-${counter.id}'),
              counter: counter,
              onDecrement: _decrement,
              onIncrement: _increment,
              onDismissed: _delete,
            );
          });
    });
  }
}
