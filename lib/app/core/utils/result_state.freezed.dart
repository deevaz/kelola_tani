// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResultState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ResultState<$T>()';
}


}

/// @nodoc
class $ResultStateCopyWith<T,$Res>  {
$ResultStateCopyWith(ResultState<T> _, $Res Function(ResultState<T>) __);
}


/// Adds pattern-matching-related methods to [ResultState].
extension ResultStatePatterns<T> on ResultState<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ResultInitial<T> value)?  initial,TResult Function( ResultLoading<T> value)?  loading,TResult Function( ResultSuccess<T> value)?  success,TResult Function( ResultFailed<T> value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ResultInitial() when initial != null:
return initial(_that);case ResultLoading() when loading != null:
return loading(_that);case ResultSuccess() when success != null:
return success(_that);case ResultFailed() when failed != null:
return failed(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ResultInitial<T> value)  initial,required TResult Function( ResultLoading<T> value)  loading,required TResult Function( ResultSuccess<T> value)  success,required TResult Function( ResultFailed<T> value)  failed,}){
final _that = this;
switch (_that) {
case ResultInitial():
return initial(_that);case ResultLoading():
return loading(_that);case ResultSuccess():
return success(_that);case ResultFailed():
return failed(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ResultInitial<T> value)?  initial,TResult? Function( ResultLoading<T> value)?  loading,TResult? Function( ResultSuccess<T> value)?  success,TResult? Function( ResultFailed<T> value)?  failed,}){
final _that = this;
switch (_that) {
case ResultInitial() when initial != null:
return initial(_that);case ResultLoading() when loading != null:
return loading(_that);case ResultSuccess() when success != null:
return success(_that);case ResultFailed() when failed != null:
return failed(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( T data)?  success,TResult Function( String? message)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ResultInitial() when initial != null:
return initial();case ResultLoading() when loading != null:
return loading();case ResultSuccess() when success != null:
return success(_that.data);case ResultFailed() when failed != null:
return failed(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( T data)  success,required TResult Function( String? message)  failed,}) {final _that = this;
switch (_that) {
case ResultInitial():
return initial();case ResultLoading():
return loading();case ResultSuccess():
return success(_that.data);case ResultFailed():
return failed(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( T data)?  success,TResult? Function( String? message)?  failed,}) {final _that = this;
switch (_that) {
case ResultInitial() when initial != null:
return initial();case ResultLoading() when loading != null:
return loading();case ResultSuccess() when success != null:
return success(_that.data);case ResultFailed() when failed != null:
return failed(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ResultInitial<T> implements ResultState<T> {
  const ResultInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultInitial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ResultState<$T>.initial()';
}


}




/// @nodoc


class ResultLoading<T> implements ResultState<T> {
  const ResultLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultLoading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ResultState<$T>.loading()';
}


}




/// @nodoc


class ResultSuccess<T> implements ResultState<T> {
  const ResultSuccess(this.data);
  

 final  T data;

/// Create a copy of ResultState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultSuccessCopyWith<T, ResultSuccess<T>> get copyWith => _$ResultSuccessCopyWithImpl<T, ResultSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ResultState<$T>.success(data: $data)';
}


}

/// @nodoc
abstract mixin class $ResultSuccessCopyWith<T,$Res> implements $ResultStateCopyWith<T, $Res> {
  factory $ResultSuccessCopyWith(ResultSuccess<T> value, $Res Function(ResultSuccess<T>) _then) = _$ResultSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$ResultSuccessCopyWithImpl<T,$Res>
    implements $ResultSuccessCopyWith<T, $Res> {
  _$ResultSuccessCopyWithImpl(this._self, this._then);

  final ResultSuccess<T> _self;
  final $Res Function(ResultSuccess<T>) _then;

/// Create a copy of ResultState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(ResultSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class ResultFailed<T> implements ResultState<T> {
  const ResultFailed([this.message]);
  

 final  String? message;

/// Create a copy of ResultState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultFailedCopyWith<T, ResultFailed<T>> get copyWith => _$ResultFailedCopyWithImpl<T, ResultFailed<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultFailed<T>&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ResultState<$T>.failed(message: $message)';
}


}

/// @nodoc
abstract mixin class $ResultFailedCopyWith<T,$Res> implements $ResultStateCopyWith<T, $Res> {
  factory $ResultFailedCopyWith(ResultFailed<T> value, $Res Function(ResultFailed<T>) _then) = _$ResultFailedCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$ResultFailedCopyWithImpl<T,$Res>
    implements $ResultFailedCopyWith<T, $Res> {
  _$ResultFailedCopyWithImpl(this._self, this._then);

  final ResultFailed<T> _self;
  final $Res Function(ResultFailed<T>) _then;

/// Create a copy of ResultState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(ResultFailed<T>(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
