import 'package:equatable/equatable.dart';

abstract class TunerState extends Equatable{
  final double frequency;

  final String note;
  final double target;
  final double distance;
  final int octave;

  final String nearestNote;
  final double nearestTarget;
  final double nearestDistance;
  final int nearestOctave;

  final bool isOnPitch;
  final bool isRecording;

  const TunerState(
    this.frequency,
    this.note,
    this.target,
    this.distance,
    this.octave,
    this.nearestNote,
    this.nearestTarget,
    this.nearestDistance,
    this.nearestOctave,
    this.isOnPitch,
    this.isRecording
  );

  @override
  List<Object> get props => [frequency, note, target, distance, octave, nearestNote, nearestTarget, nearestDistance, nearestOctave, isOnPitch, isRecording];
}

class Ready extends TunerState {
  const Ready(double frequency, String note, double target, double distance, int octave, String nearestNote, double nearestTarget, double nearestDistance, int nearestOctave, bool isOnPitch, bool isRecording) : super(frequency, note, target, distance, octave, nearestNote, nearestTarget, nearestDistance, nearestOctave, isOnPitch, isRecording);

  @override
  String toString() => "Tuner is ready.";
}

class Running extends TunerState {
  const Running(double frequency, String note, double target, double distance, int octave, String nearestNote, double nearestTarget, double nearestDistance, int nearestOctave, bool isOnPitch, bool isRecording) : super(frequency, note, target, distance, octave, nearestNote, nearestTarget, nearestDistance, nearestOctave, isOnPitch, isRecording);

  @override
  String toString() => "Tuner is currently running.";
}

class Stopped extends TunerState {
  const Stopped() : super(null, null, null, null, null, null, null, null, null, null, null);

  @override
  String toString() => "Tuner stopped.";
}