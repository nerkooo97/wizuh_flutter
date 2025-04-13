import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/repository/repository.dart';

import 'cubit.dart';

class EventListCubit extends Cubit<EventListState> {
  EventListCubit() : super(EventListLoading());
  Timer? timer;

  Future<void> onLoad({
    CategoryModel? category,
    SortModel? sort,
    String? keyword,
  }) async {
    int timeout = 0;
    if (keyword != null && keyword.isNotEmpty) {
      timeout = 500;
    }
    timer?.cancel();
    timer = Timer(Duration(milliseconds: timeout), () async {
      final repository = EventRepository();
      final result = await repository.fetchEvents(
      );
      if (result != null) {
        emit(EventListSuccess(
        ));
      }
    });
  }
}
