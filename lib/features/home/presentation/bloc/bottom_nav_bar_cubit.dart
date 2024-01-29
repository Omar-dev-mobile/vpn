import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/home_widget.dart';


class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(InitialState());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static BottomNavBarCubit get(context) => BlocProvider.of(context);

  void updateNavBar(int index) async {
    emit(UpdatedState(index));
  }

  int get index => state.currentIndex;


  Widget builder(int index) {
    Widget builder;
    switch (index) {
      case 0:
        builder =  Container();
        break;
      case 1:
        builder = const HomeWidget();
        break;
      case 2:
        builder =  Container();
        break;
      default:
        builder = Container();
    }
    return builder;
  }

}

abstract class BottomNavBarState {
  int get currentIndex;
}

class InitialState extends BottomNavBarState {
  @override
  int get currentIndex => 1;
}

class UpdatedState extends BottomNavBarState {
  final int index;

  UpdatedState(this.index);

  @override
  int get currentIndex => index;
}
