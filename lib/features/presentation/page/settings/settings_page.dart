import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/di/injection.dart';
import 'package:restaurant_app/features/presentation/bloc/setting/setting_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/setting/setting_event.dart';
import 'package:restaurant_app/features/presentation/bloc/setting/setting_state.dart';
import 'package:restaurant_app/features/presentation/widget/custom_dialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SettingBloc>()..add(const CheckScheduleEvent()),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              _buildNotificationToggle(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationToggle(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'Enable Daily Notification',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            BlocBuilder<SettingBloc, SettingState>(
              builder: (context, state) {
                if (state is SettingScheduleSetState) {
                  return Switch.adaptive(
                    value: true,
                    onChanged: (_) {
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        BlocProvider.of<SettingBloc>(context)
                            .add(const CancelScheduleEvent());
                      }
                    },
                  );
                } else {
                  return Switch.adaptive(
                    value: false,
                    onChanged: (_) {
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        BlocProvider.of<SettingBloc>(context).add(
                          const SetScheduleEvent(),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
