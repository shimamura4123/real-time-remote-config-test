import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_time_remote_config/remote_config_state.dart';

const _defaultSettings = {
  "top_page_label": "default local label",
};

typedef RemoteConfigMap = Map<String, RemoteConfigValue>;

final remoteConfigProvider =
    StateNotifierProvider<RemoteConfigNotifier, RemoteConfigState>(
  (ref) => RemoteConfigNotifier(),
);

class RemoteConfigNotifier extends StateNotifier<RemoteConfigState> {
  RemoteConfigNotifier({bool isDebug = false})
      : super(RemoteConfigState.initialize()) {
    _initialize(isDebug: isDebug);
  }

  Future<void> _initialize({required bool isDebug}) async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    state = RemoteConfigState(state: remoteConfig.getAll());
    await remoteConfig.setDefaults(_defaultSettings);

    remoteConfig.onConfigUpdated.listen((event) async {
      final result = await remoteConfig.activate();
      if (result) {
        state = RemoteConfigState(state: remoteConfig.getAll());
      }
    });

    final result = await remoteConfig.fetchAndActivate();
    if (result) {
      state = RemoteConfigState(state: remoteConfig.getAll());
    }
  }
}
