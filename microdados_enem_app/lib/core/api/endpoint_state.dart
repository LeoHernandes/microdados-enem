sealed class EndpointState<F, S> {
  const EndpointState();

  const factory EndpointState.idle() = IdleState;
  const factory EndpointState.loading() = LoadingState;
  const factory EndpointState.error(F error) = ErrorState;
  const factory EndpointState.success(S data) = SuccessState;

  bool get isError => this is ErrorState;
  bool get isLoading => this is LoadingState;
  bool get isSuccess => this is SuccessState;
  bool get isIdle => this is IdleState;

  T when<T>({
    required T Function() isIdle,
    required T Function() isLoading,
    required T Function(F error) isError,
    required T Function(S data) isSuccess,
  }) {
    switch (this) {
      case IdleState<F, S> _:
        return isIdle();

      case LoadingState<F, S> _:
        return isLoading();

      case ErrorState<F, S>(:final error):
        return isError(error);

      case SuccessState<F, S>(:final data):
        return isSuccess(data);
    }
  }

  T whenOrDefault<T>({
    T Function()? isIdle,
    T Function()? isLoading,
    T Function(F error)? isError,
    T Function(S data)? isSuccess,
    required T defaultValue,
  }) {
    switch (this) {
      case IdleState<F, S> _:
        return isIdle != null ? isIdle() : defaultValue;

      case LoadingState<F, S> _:
        return isLoading != null ? isLoading() : defaultValue;

      case ErrorState<F, S>(:final error):
        return isError != null ? isError(error) : defaultValue;

      case SuccessState<F, S>(:final data):
        return isSuccess != null ? isSuccess(data) : defaultValue;
    }
  }
}

class IdleState<F, S> extends EndpointState<F, S> {
  const IdleState();
}

class LoadingState<F, S> extends EndpointState<F, S> {
  const LoadingState();
}

class ErrorState<F, S> extends EndpointState<F, S> {
  final F error;

  const ErrorState(this.error);
}

class SuccessState<F, S> extends EndpointState<F, S> {
  final S data;

  const SuccessState(this.data);
}
