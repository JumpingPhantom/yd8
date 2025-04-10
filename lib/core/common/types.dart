typedef FormValidator = String? Function(String?);

enum Gender { male, female, other }

// Usecase is an abstract class that defines a generic use case.
// T is the return type of the use case.
// P is the type of the parameters that the use case takes.
abstract class Usecase<T, P> {
  Future<T> call(P params);
}

// Result is an abstract class that represents the result of a use case.
// T is the type of the data that the use case returns.
// It can be either a success (Ok) or a failure (Err).
abstract class Result<T> {
  final T? data;
  final Exception? exception;

  const Result({this.data, this.exception});
}

// Ok is a class that represents a successful result.
// It contains the data that the use case returned.
class Ok<T> extends Result<T> {
  const Ok(T data) : super(data: data);
}

// Err is a class that represents a failed result.
// It contains the exception that the use case threw.
class Err<T> extends Result<T> {
  const Err(Exception exception) : super(exception: exception);
}
