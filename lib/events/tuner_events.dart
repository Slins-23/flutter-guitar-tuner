import "package:equatable/equatable.dart";

abstract class TunerEvent extends Equatable {
  const TunerEvent();

  @override
  List<Object> get props => [];
}

class Start extends TunerEvent {

  const Start();

  @override
  String toString() => "Starting.";
}

class Update extends TunerEvent {
  final List<Object> data;

  const Update(this.data);

  @override
  List<Object> get props => [data];

  @override
  String toString() => "Updating... Current data: $data";
}

class Stop extends TunerEvent {}
