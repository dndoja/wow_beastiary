import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wow_armory/api/card_search_result.dart';
import 'package:wow_armory/thing.dart';

import 'home_cubit.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _key = new GlobalKey();

  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animationController.forward();
  }

  Offset getLocalPosition(WidgetData widgetData) {
    if (_key.currentContext == null) return Offset(0, 0);
    RenderBox renderBox = _key.currentContext.findRenderObject();
    Offset pos =
        renderBox.globalToLocal(Offset(widgetData.xPos, widgetData.yPos));
    return Offset(pos.dx, renderBox.size.height - pos.dy - widgetData.height);
  }

  Offset getStackCenter() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double middleX = screenWidth / 2;
    double middleY = screenHeight / 2;
    return Offset(middleX, middleY);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return BlocBuilder<HomeCubit, HomeState>(builder: (builder, state) {
            return Stack(key: _key, children: [
              Column(
                children: [
                  TextField(
                      onChanged: (value) =>
                          builder.bloc<HomeCubit>().search(value),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        icon: Icon(Icons.search),
                      )),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: state.cards.length,
                      itemBuilder: (context, index) => CardThumbnail(
                        state.cards[index],
                        onImageTap: (widgetData){
                          _animationController.forward();
                          builder
                            .bloc<HomeCubit>()
                            .focusOnCard(FocusedCard(state.cards[index], widgetData));
                          },
                      ),
                    ),
                  ),
                ],
              ),
              state.focusedCard != null
                  ? () {
                      final startPosition =
                          getLocalPosition(state.focusedCard.position);
                      final goalPosition = getStackCenter();
                      final startWidth = state.focusedCard.position.width;
                      final startHeight = state.focusedCard.position.height;
                      final goalWidth = startWidth * 3;
                      final goalHeight = startHeight * 3;
                      final width = min(startWidth + goalWidth * _animationController.value, goalWidth);
                      final height = min(startHeight + goalHeight * _animationController.value, goalHeight);
                      final goalY = goalPosition.dy - height / 2;
                      final goalX = goalPosition.dx - width / 2;

                      return Positioned(
                          left: goalX,
                          bottom: goalY,
                          child: Container(
                              width: width,
                              height: height,
                              child:
                                  GestureDetector(
                                      onTap: (){
                                        _animationController.reset();
                                        context.bloc<HomeCubit>().removeFocusFromCard();
                                      },
                                      child: Image.network(state.focusedCard.card.image))));
                    }()
                  : SizedBox.shrink()
            ]);
          });
        });
  }
}

class CardPreview extends StatelessWidget {
  final FocusedCard _card;

  const CardPreview(this._card, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _card != null
        ? Positioned(
            bottom: _card.position.yPos,
            left: _card.position.xPos,
            child: Container(
                width: _card.position.width,
                height: _card.position.height,
                child: Image.network(_card.card.image)))
        : SizedBox.shrink();
  }
}

class CardThumbnail extends StatelessWidget {
  final HSCard _card;
  final WidgetDataCallback onImageTap;

  const CardThumbnail(this._card, {Key key, this.onImageTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          Expanded(
            child: HeightReporter(
              child: Image.network(_card.image),
              onTap: onImageTap,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 16),
              child: Center(
                  child: Text(_card.name, style: TextStyle(fontSize: 18)))),
        ]));
  }
}
