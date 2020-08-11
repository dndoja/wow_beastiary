import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_cubit.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        builder: (builder, state) => Column(
              children: [
                TextField(
                    onSubmitted: (value) =>
                        builder.bloc<HomeCubit>().search(value),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      icon: Icon(Icons.search),
                    )),
                Expanded(
                    child: ListView.builder(
                        itemCount: state.cards.length,
                        itemBuilder: (context, index) => ListTile(
                              title: Text('${state.cards[index].name}'),
                            ))),
              ],
            ));
  }
}
