part of 'fetch_quiz_bloc.dart';

// Removed import 'package:equatable/equatable.dart'; 

abstract class FetchQuizEvent extends Equatable {
  const FetchQuizEvent();

  @override
  List<Object> get props => [];
}

class FetchQuizRequested extends FetchQuizEvent {}
