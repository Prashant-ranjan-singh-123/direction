class PrashantAppOpenPermissionState {}

class InitialState extends PrashantAppOpenPermissionState {
  bool loading;
  int canLoad; // 0 -> do nothing, 1 -> open app, 2 -> not open app
  InitialState({required this.loading, required this.canLoad});
}
