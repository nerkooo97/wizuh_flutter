import 'package:listar_flutter_pro/models/model.dart';

abstract class EventListState {}

class EventListLoading extends EventListState {}

class EventListSuccess extends EventListState {

  EventListSuccess();
}
