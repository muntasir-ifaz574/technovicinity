// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Auth)
const authProvider = AuthProvider._();

final class AuthProvider
    extends $AsyncNotifierProvider<Auth, Either<Failure, dynamic>> {
  const AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();
}

String _$authHash() => r'881555c8645196bf45b4bfdb8a9b88257c70adfa';

abstract class _$Auth extends $AsyncNotifier<Either<Failure, dynamic>> {
  FutureOr<Either<Failure, dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Either<Failure, dynamic>>,
              Either<Failure, dynamic>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Either<Failure, dynamic>>,
                Either<Failure, dynamic>
              >,
              AsyncValue<Either<Failure, dynamic>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
