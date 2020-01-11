import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:tuner/extensions/tuner_extension.dart';
import "package:tuner/extensions/globals.dart" as globals;

class TunerBloc extends Bloc<TunerEvent, TunerState> {

  StreamSubscription<List<Object>> _flutterFftSubscription;

  @override
  TunerState get initialState =>
      Ready(null, null, null, null, null, null, null, null, null, null, null);

  @override
  Stream<TunerState> mapEventToState(TunerEvent event) async* {
    if (event is Start) {
      yield* _mapStartToState(event);
    } else if (event is Update) {
      yield* _mapUpdateToState(event);
    } else if (event is Stop) {
      yield* _mapStopToState(event);
    } else {
      throw new Exception(
          "Exception thrown at 'tuner_bloc.dart', in the method 'mapEventToState'.");
    }
  }

  Stream<TunerState> _mapStartToState(Start start) async* {
    yield Running(
        globals.flutterFft.getFrequency,
        globals.flutterFft.getNote,
        globals.flutterFft.getTarget,
        globals.flutterFft.getDistance,
        globals.flutterFft.getOctave,
        globals.flutterFft.getNearestNote,
        globals.flutterFft.getNearestTarget,
        globals.flutterFft.getNearestDistance,
        globals.flutterFft.getNearestOctave,
        globals.flutterFft.getIsOnPitch,
        globals.flutterFft.getIsRecording);
    //flutterFft.setAndroidAudioSource = androidAudioSource;


    await globals.flutterFft.startRecorder();
    _flutterFftSubscription?.cancel();
    _flutterFftSubscription = globals.flutterFft.onRecorderStateChanged.listen((data) {
      add(Update(data));
    });
  }

  Stream<TunerState> _mapUpdateToState(Update update) async* {
    yield Running(
        globals.flutterFft.getFrequency,
        globals.flutterFft.getNote,
        globals.flutterFft.getTarget,
        globals.flutterFft.getDistance,
        globals.flutterFft.getOctave,
        globals.flutterFft.getNearestNote,
        globals.flutterFft.getNearestTarget,
        globals.flutterFft.getNearestDistance,
        globals.flutterFft.getNearestOctave,
        globals.flutterFft.getIsOnPitch,
        globals.flutterFft.getIsRecording);
    //flutterFft.setTolerance = update.data[0]; // TOLERANCE

    globals.flutterFft.setFrequency = update.data[1];

    globals.flutterFft.setNote = update.data[2];
    globals.flutterFft.setTarget = update.data[3];
    globals.flutterFft.setDistance = update.data[4];
    globals.flutterFft.setOctave = update.data[5];

    globals.flutterFft.setNearestNote = update.data[6];
    globals.flutterFft.setNearestTarget = update.data[7];
    globals.flutterFft.setNearestDistance = update.data[8];
    globals.flutterFft.setNearestOctave = update.data[9];

    globals.flutterFft.setIsOnPitch = update.data[10];
  }

  Stream<TunerState> _mapStopToState(Stop stop) async* {
    if (state is Running) {
      await globals.flutterFft.stopRecorder();
      _flutterFftSubscription?.cancel();
      yield this.initialState;
    }
  }

  @override
  Future<void> close() async {
    if (state is Running) {
      await globals.flutterFft.stopRecorder();
    }

    _flutterFftSubscription?.cancel();
    return super.close();
  }
}
