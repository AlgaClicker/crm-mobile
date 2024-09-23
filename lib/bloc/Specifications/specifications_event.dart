import 'package:equatable/equatable.dart';

abstract class SpecificationsEvent extends Equatable {
  const SpecificationsEvent();

  @override
  List<Object> get props => [];
}

class LoadSpecifications extends SpecificationsEvent {}
