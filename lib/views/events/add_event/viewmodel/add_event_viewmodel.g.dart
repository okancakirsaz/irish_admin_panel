// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_event_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddEventViewModel on _AddEventViewModelBase, Store {
  late final _$isPhysicalEventAtom =
      Atom(name: '_AddEventViewModelBase.isPhysicalEvent', context: context);

  @override
  bool get isPhysicalEvent {
    _$isPhysicalEventAtom.reportRead();
    return super.isPhysicalEvent;
  }

  @override
  set isPhysicalEvent(bool value) {
    _$isPhysicalEventAtom.reportWrite(value, super.isPhysicalEvent, () {
      super.isPhysicalEvent = value;
    });
  }

  late final _$_AddEventViewModelBaseActionController =
      ActionController(name: '_AddEventViewModelBase', context: context);

  @override
  dynamic changeIsPhysicalEventState(bool value) {
    final _$actionInfo = _$_AddEventViewModelBaseActionController.startAction(
        name: '_AddEventViewModelBase.changeIsPhysicalEventState');
    try {
      return super.changeIsPhysicalEventState(value);
    } finally {
      _$_AddEventViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isPhysicalEvent: ${isPhysicalEvent}
    ''';
  }
}
