// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_events_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ActiveEventsViewModel on _ActiveEventsViewModelBase, Store {
  late final _$isPageLoadedAtom =
      Atom(name: '_ActiveEventsViewModelBase.isPageLoaded', context: context);

  @override
  bool get isPageLoaded {
    _$isPageLoadedAtom.reportRead();
    return super.isPageLoaded;
  }

  @override
  set isPageLoaded(bool value) {
    _$isPageLoadedAtom.reportWrite(value, super.isPageLoaded, () {
      super.isPageLoaded = value;
    });
  }

  late final _$eventsAtom =
      Atom(name: '_ActiveEventsViewModelBase.events', context: context);

  @override
  ObservableList<EventModel> get events {
    _$eventsAtom.reportRead();
    return super.events;
  }

  @override
  set events(ObservableList<EventModel> value) {
    _$eventsAtom.reportWrite(value, super.events, () {
      super.events = value;
    });
  }

  late final _$getActiveEventsAsyncAction = AsyncAction(
      '_ActiveEventsViewModelBase.getActiveEvents',
      context: context);

  @override
  Future<void> getActiveEvents() {
    return _$getActiveEventsAsyncAction.run(() => super.getActiveEvents());
  }

  late final _$cancelEventAsyncAction =
      AsyncAction('_ActiveEventsViewModelBase.cancelEvent', context: context);

  @override
  Future<void> cancelEvent(String id) {
    return _$cancelEventAsyncAction.run(() => super.cancelEvent(id));
  }

  @override
  String toString() {
    return '''
isPageLoaded: ${isPageLoaded},
events: ${events}
    ''';
  }
}
