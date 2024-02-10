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

  late final _$blockUserButtonTextAtom =
      Atom(name: '_UsersViewModelBase.blockUserButtonText', context: context);

  @override
  String? get blockUserButtonText {
    _$blockUserButtonTextAtom.reportRead();
    return super.blockUserButtonText;
  }

  @override
  set blockUserButtonText(String? value) {
    _$blockUserButtonTextAtom.reportWrite(value, super.blockUserButtonText, () {
      super.blockUserButtonText = value;
    });
  }

  late final _$getUsersAsyncAction =
      AsyncAction('_UsersViewModelBase.getUsers', context: context);

  @override
  Future<void> getUsers() {
    return _$getUsersAsyncAction.run(() => super.getUsers());
  }

  late final _$getAllUsersFirstInitAsyncAction =
      AsyncAction('_UsersViewModelBase.getAllUsersFirstInit', context: context);

  @override
  Future<void> getAllUsersFirstInit() {
    return _$getAllUsersFirstInitAsyncAction
        .run(() => super.getAllUsersFirstInit());
  }

  late final _$handleBlockUserAsyncAction =
      AsyncAction('_UsersViewModelBase.handleBlockUser', context: context);

  @override
  Future<void> handleBlockUser(UserDataModel user) {
    return _$handleBlockUserAsyncAction.run(() => super.handleBlockUser(user));
  }

  late final _$deleteProfileImageAsyncAction =
      AsyncAction('_UsersViewModelBase.deleteProfileImage', context: context);

  @override
  Future<void> deleteProfileImage(UserDataModel user) {
    return _$deleteProfileImageAsyncAction
        .run(() => super.deleteProfileImage(user));
  }

  late final _$deletePostAsyncAction =
      AsyncAction('_UsersViewModelBase.deletePost', context: context);

  @override
  Future<void> deletePost(UserDataModel user, String postId) {
    return _$deletePostAsyncAction.run(() => super.deletePost(user, postId));
  }

  late final _$_UsersViewModelBaseActionController =
      ActionController(name: '_UsersViewModelBase', context: context);

  @override
  dynamic fetchBlockUserButtonText(bool isUserBlocked) {
    final _$actionInfo = _$_UsersViewModelBaseActionController.startAction(
        name: '_UsersViewModelBase.fetchBlockUserButtonText');
    try {
      return super.fetchBlockUserButtonText(isUserBlocked);
    } finally {
      _$_UsersViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
allUsers: ${allUsers},
isLoadSuccessful: ${isLoadSuccessful},
blockUserButtonText: ${blockUserButtonText}
    ''';
  }
}
