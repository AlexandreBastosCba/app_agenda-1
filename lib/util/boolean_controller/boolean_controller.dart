class BooleanController {
  bool _value = false;

  bool get value => _value;

  void toggle() {
    _value = !_value;
  }

  void set(bool value) {
    _value = value;
  }
}
