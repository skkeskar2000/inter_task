part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}
class ErrorState extends SignInState {}
class SignInSuccess extends SignInState {}
