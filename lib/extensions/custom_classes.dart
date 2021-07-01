class TuningList {
  List<String>? tuning;
  int length = 0;

  TuningList(List<String> tuning) {
    this.tuning = tuning;
    this.length = tuning.length;
  }

  String operator [](int idx) => tuning![idx];
  void operator []=(int idx, String val) {
    tuning![idx] = val;
  }

  bool operator ==(dynamic other) {
    // print("Lhs: ${tuning} | Type: ${this.runtimeType}");
    // print("Done: ${done} | Type: ${done.runtimeType}");
    // TuningList other = done as TuningList;

    if (tuning!.length != other.length) {
      return false;
    }

    if (other is List<String>) {
      TuningList oth = TuningList(other);

      for (int i = 0; i < tuning!.length; i++) {
        if (tuning![i] != oth[i]) {
          return false;
        }
      }
    } else {
      for (int i = 0; i < tuning!.length; i++) {
        if (tuning![i] != other[i]) {
          return false;
        }
      }
    }

    return true;
  }

  // bool operator ==(covariant TuningList other) {
  //   if (tuning!.length != other.length) {
  //     return false;
  //   }

  //   for (int i = 0; i < tuning!.length; i++) {
  //     if (tuning![i] != other[i]) {
  //       return false;
  //     }
  //   }

  //   return true;
  // }

  int get hashCode => tuning.hashCode;

  List<String> get getList => tuning!;

  String toString() => tuning!.toString();
}
