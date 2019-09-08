
class Clock {
  int utcOffset;
  String label;

  Clock({
    this.utcOffset,
    this.label,
  });

  @override
  String toString() {
    return ('utcOffset: $utcOffset, label: $label,');
  }


}