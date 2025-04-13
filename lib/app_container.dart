import 'dart:async';

import 'package:assistive_touch/assistive_touch.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/screens/screen.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:hugeicons/hugeicons.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  State<AppContainer> createState() {
    return _AppContainerState();
  }
}

class _AppContainerState extends State<AppContainer> {
  int _selectedIndex = 0;
  StreamSubscription? _connectivity;
  StreamSubscription? _message;
  StreamSubscription? _messageOpenedApp;
  String? _lastConnectivity;
  bool readyConnectivity = false;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      readyConnectivity = true;
      final state = AppBloc.applicationCubit.state;
      if (state is ApplicationStateSuccess && state.onboarding == true) {
        Navigator.pushNamed(context, Routes.onboarding);
      }
    });

    _connectivity = Connectivity().onConnectivityChanged.listen((result) {
      if (readyConnectivity && result.isNotEmpty) {
        if (_lastConnectivity == result.last.toString()) {
          return;
        }
        _lastConnectivity = result.last.toString();
        String title = 'no_internet_connection';
        IconData icon = Icons.wifi_off;
        Color color = Colors.red;
        if (result.last != ConnectivityResult.none) {
          title = 'internet_connected';
          icon = Icons.wifi;
          color = Colors.green;
        }
        AppBloc.messageBloc.add(
          MessageEvent(
            message: title,
            icon: Icon(
              icon,
              color: color,
            ),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    });

    _message = FirebaseMessaging.onMessage.listen((message) {
      _notificationHandle(message);
    });
    _messageOpenedApp = FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _notificationHandle(message);
    });
  }

  @override
  void dispose() {
    _message?.cancel();
    _messageOpenedApp?.cancel();
    _connectivity?.cancel();
    super.dispose();
  }

  ///check route need auth
  bool _requireAuth(int index) {
    switch (index) {
      case 0:
      case 1:
      case 2:
        return false;
      default:
        return true;
    }
  }

  ///Handle When Press Notification
  void _notificationHandle(RemoteMessage message) {
    final notification = NotificationModel.fromJson(message);
    if (notification.target != null) {
      Navigator.pushNamed(
        context,
        notification.target!,
        arguments: notification.item,
      );
    }
  }

  ///Force switch home when authentication state change
  void _listenAuthenticateChange(AuthenticationState authentication) async {
    if (authentication == AuthenticationState.fail &&
        _requireAuth(_selectedIndex)) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: _selectedIndex,
      );
      if (result != null) {
        setState(() {
          _selectedIndex = result as int;
        });
      } else {
        setState(() {
          _selectedIndex = 0;
        });
      }
    }
  }

  ///On change tab bottom menu and handle when not yet authenticate
  void _onItemTapped(int index) async {
    if (AppBloc.userCubit.state == null && _requireAuth(index)) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: index,
      );
      if (result == null) return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onShowCase() async {
    Widget? buildSelect(String domain) {
      if (domain == Application.domain) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            ),
          ),
        );
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget home = const Home();
    if (Application.setting.useLayoutWidget) {
      home = const HomeWidget();
    }
    return Scaffold(
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, authentication) async {
          _listenAuthenticateChange(authentication);
        },
        child: Stack(
          children: [
            IndexedStack(
              index: _selectedIndex,
              children: [
                home,
                const Discovery(),
                const BlogList(),
                /* const AutobuskeLinije(), */
                const Account()
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome01,
              color: _selectedIndex == 0 ? Colors.green : Colors.grey,
              size: 25.0,
            ),
            label: Translate.of(context).translate('home'),
          ),
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedAlignBoxBottomLeft,
              color: _selectedIndex == 1 ? Colors.green : Colors.grey,
              size: 25.0,
            ),
            label: Translate.of(context).translate('discovery'),
          ),
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedNews,
              color: _selectedIndex == 2 ? Colors.green : Colors.grey,
              size: 27.0,
            ),
            label: Translate.of(context).translate('blog'),
          ),
          /* BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedBus01,
              color: _selectedIndex == 3 ? Colors.green : Colors.grey,
              size: 27.0,
            ),
            label: 'Autobusi',
          ), */
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedUserAccount,
              color: _selectedIndex == 4 ? Colors.green : Colors.grey,
              size: 30.0,
            ),
            label: Translate.of(context).translate('account'),
          ),
        ],
        selectedFontSize: 12,
        selectedItemColor: Colors.green, // Boja teksta za aktivnu stavku
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
