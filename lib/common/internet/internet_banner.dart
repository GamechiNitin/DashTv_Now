import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/internet_cubit.dart';

class InternetBanner extends StatelessWidget {
  final Widget child;
  final bool showAtTop;

  const InternetBanner({super.key, required this.child, this.showAtTop = true});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        final banner = AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: state.isConnected ? 0 : 28,
          width: double.infinity,
          color: state.isConnected ? Colors.green : Colors.redAccent,
          alignment: Alignment.center,
          child: Text(
            state.isConnected ? "Internet Connected" : "No Internet Connection",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        );

        return Material(
          child: Column(
            children: [
              if (showAtTop) banner,
              Expanded(child: child),
              if (!showAtTop) banner,
            ],
          ),
        );
      },
    );
  }
}
