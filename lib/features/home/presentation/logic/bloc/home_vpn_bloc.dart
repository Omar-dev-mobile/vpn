import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vpn/core/native/VPNIOSManager.dart';
import 'package:vpn/locator.dart';

part 'home_vpn_event.dart';
part 'home_vpn_state.dart';

class HomeVpnBloc extends Bloc<HomeVpnEvent, HomeVpnState> {
  StreamSubscription<dynamic>? _vpnStatusSubscription;

  VPNIOSManager get vpnIOSManager => locator<VPNIOSManager>();
  HomeVpnBloc() : super(HomeVpnInitial()) {
    on<HomeVpnEvent>((event, emit) async {
      await handelVpn(emit);
    });
  }

  Future handelVpn(emit) async {
    try {
      emit(HomeLoadingVpnState());
      var getStatus = await vpnIOSManager.getStatus();
      emit(HomeSuccessVpnState(status: getStatus.status));
      _vpnStatusSubscription =
          vpnIOSManager.vpnStatusStream().listen((event) async {
        print("event ${event.status}");
        await emit(HomeSuccessVpnState(status: event.status));
      });
    } catch (e) {
      emit(HomeErrorVpnState(error: "An unexpected error occurred"));
    }
  }

  @override
  Future<void> close() {
    _vpnStatusSubscription?.cancel();
    return super.close();
  }
}
