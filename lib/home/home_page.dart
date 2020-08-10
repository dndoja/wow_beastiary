import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
            decoration: InputDecoration(
          hintText: 'Search',
          icon: Icon(Icons.search),
        )),
        Expanded(
            child: ListView(
                children: List.generate(
                    30,
                    (index) => Center(
                          child: Text(
                            'Item $index',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        )))),
      ],
    );
  }
}
