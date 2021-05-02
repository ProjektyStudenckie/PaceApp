import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.photo,
  });

  final String email;
  final String id;
  final String name;
  final String photo;

  static const anonymous = User(id: '', email: '', name: '', photo: '');

  bool get isAnonymous => this == User.anonymous;
  bool get isNotAnonymous => this != User.anonymous;

  @override
  List<Object> get props => [email, id, name, photo];
}
