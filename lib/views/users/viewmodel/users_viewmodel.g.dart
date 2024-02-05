// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UsersViewModel on _UsersViewModelBase, Store {
  late final _$allUsersAtom =
      Atom(name: '_UsersViewModelBase.allUsers', context: context);

  @override
  ObservableList<UserDataModel> get allUsers {
    _$allUsersAtom.reportRead();
    return super.allUsers;
  }

  @override
  set allUsers(ObservableList<UserDataModel> value) {
    _$allUsersAtom.reportWrite(value, super.allUsers, () {
      super.allUsers = value;
    });
  }

  late final _$isLoadSuccessfulAtom =
      Atom(name: '_UsersViewModelBase.isLoadSuccessful', context: context);

  @override
  bool get isLoadSuccessful {
    _$isLoadSuccessfulAtom.reportRead();
    return super.isLoadSuccessful;
  }

  @override
  set isLoadSuccessful(bool value) {
    _$isLoadSuccessfulAtom.reportWrite(value, super.isLoadSuccessful, () {
      super.isLoadSuccessful = value;
    });
  }

  late final _$getAllUsersFirstInitAsyncAction =
      AsyncAction('_UsersViewModelBase.getAllUsersFirstInit', context: context);

  @override
  Future<void> getAllUsersFirstInit() {
    return _$getAllUsersFirstInitAsyncAction
        .run(() => super.getAllUsersFirstInit());
  }

  @override
  String toString() {
    return '''
allUsers: ${allUsers},
isLoadSuccessful: ${isLoadSuccessful}
    ''';
  }
}
