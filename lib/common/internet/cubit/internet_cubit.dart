import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetState {
  final bool isConnected;
  InternetState(this.isConnected);
}

class InternetCubit extends Cubit<InternetState> {
  late StreamSubscription<InternetStatus> _subscription;

  InternetCubit() : super(InternetState(true)) {
    _subscription = InternetConnection().onStatusChange.listen((status) {
      final connected = status == InternetStatus.connected;
      emit(InternetState(connected));
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
