// ignore_for_file: constant_identifier_names

enum OptionsStates {
  LOADING,
  ERROR,
  NONE,
  SOME,
}

/// Wrapper type to handle async data fetch in code, especially with wrapping
/// this inside Rx<> type of GetX to perform components rebuild when the value
/// is updated.
/// 
/// It is initialized to `NONE` as meaning that there is no data inside.
/// If the type needs to be reinitialized, it can be set again to `NONE` 
/// with [setNone] setter.
/// 
/// When an async call is made, the value should be changed to `LOADING`
/// to ensure correctly matching on it and displaying a loader. It can be
/// done by using [setLoading]
/// 
/// If an error occured during the process of fetching data, it can be catched
/// and referenced here by changing the type with [setError]
/// 
/// If the data could have been fetched correctly, it can be put in here with
/// [setSome].
/// 
/// By respecting this process, this type can ensure to handle the state of 
/// the data it contains correctly. You can [match] on the different cases 
/// using the function to do so. It can be used to change the Widget depending
/// on the state of the variable.
class Options<T> {
  OptionsStates _type = OptionsStates.NONE;
  T? _value;
  Exception? _exception;

  void setLoading() {
    _type = OptionsStates.LOADING;
  }

  void setNone() {
    _type = OptionsStates.NONE;
  }

  void setSome(T value) {
    _value = value;
    _type = OptionsStates.SOME;
  }

  void setError(Exception e) {
    _exception = e;
    _type = OptionsStates.ERROR;
  }

  T getValue() {
    if (_type != OptionsStates.SOME) {
      throw TypeError();
    }
    return _value!;
  }

  G match<G>({
    required G Function() onNone,
    required G Function() onLoading,
    required G Function(Exception) onError,
    required G Function(T) onSome,
  }) {
    switch(_type) {
      case OptionsStates.NONE:
        return onNone();
      case OptionsStates.LOADING:
       return onLoading();
      case OptionsStates.ERROR:
        return onError(_exception!);
      case OptionsStates.SOME:
        return onSome(_value!);
    } 
  }
}
