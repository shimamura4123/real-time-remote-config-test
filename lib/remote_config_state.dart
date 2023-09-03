import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_config_state.freezed.dart';

@freezed
class RemoteConfigState with _$RemoteConfigState {
  const factory RemoteConfigState({
    required Map<String, RemoteConfigValue> state,
  }) = _RemoteConfigState;

  factory RemoteConfigState.initialize() => const RemoteConfigState(state: {});
}

extension RemoteConfigStateValue on RemoteConfigState {
  String valueAsString(String key) {
    try {
      return state[key]!.asString();
    } catch (e) {
      throw const Assert("No string for the specified Key");
    }
  }

  bool valueAsBool(String key) {
    try {
      return state[key]!.asBool();
    } catch (e) {
      throw const Assert("No bool value for the specified Key");
    }
  }

  int valueAsInt(String key) {
    try {
      return state[key]!.asInt();
    } catch (e) {
      throw const Assert("No int value for the specified Key");
    }
  }

  double valueAsDouble(String key) {
    try {
      return state[key]!.asDouble();
    } catch (e) {
      throw const Assert("No double value for the specified Key");
    }
  }
}
