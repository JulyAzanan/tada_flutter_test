import 'package:get/get.dart';
import 'package:tada_flutter_test/utils/options.dart';

class Handler {
  static Future<bool> apiCallHandler<T>({
    required Future<Response<T>> Function() apiMethod,
    Rx<Options<T>> Function()? accessor,
    Future<void> Function(T)? onSuccess,
    Future<void> Function(Exception)? onFailure,
  }) async {
    try {
      if (accessor != null) {
        accessor().value.setLoading();
        accessor().refresh();
      }
      final result = await apiMethod();

      if (accessor != null) {
        accessor()
            .value
            .setSome(result.body!); // can't be null from the api call written
        accessor().refresh();
      }

      if (onSuccess != null) {
        await onSuccess(result.body!);
      }

      return true;
    } on Exception catch (e) {
      if (accessor != null) {
        accessor().value.setError(e);
        accessor().refresh();

        if (onFailure != null) {
          await onFailure(e);
        }

        return false;
      }

      if (onFailure != null) {
        await onFailure(e);
        return false;
      }

      rethrow;
    }
  }
}
