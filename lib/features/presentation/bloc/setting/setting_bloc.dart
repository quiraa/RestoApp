import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/utils/background_service.dart';
import 'package:restaurant_app/core/utils/date_time_helper.dart';
import 'package:restaurant_app/features/data/preference/app_preference.dart';
import 'package:restaurant_app/features/presentation/bloc/setting/setting_event.dart';
import 'package:restaurant_app/features/presentation/bloc/setting/setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingInitialState()) {
    on<CheckScheduleEvent>(onCheckSchedule);
    on<SetScheduleEvent>(onSetSchedule);
    on<CancelScheduleEvent>(onScheduleCancel);
  }

  Future<void> onCheckSchedule(
    CheckScheduleEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(const SettingLoadingState());
    bool? value = await AppPreference.getNotif();
    if (value == true) {
      emit(const SettingScheduleSetState());
    } else {
      emit(const SettingScheduleCanceltate());
    }
  }

  Future<void> onSetSchedule(
    SetScheduleEvent event,
    Emitter<SettingState> emit,
  ) async {
    print('Setting Notification...');
    emit(const SettingLoadingState());
    await AndroidAlarmManager.periodic(
      const Duration(hours: 24),
      1,
      BackgroundService.callback,
      startAt: DateTimeHelper.format(),
      exact: true,
      wakeup: true,
    );
    await AppPreference.setNotif(true);
    print('Notification Set!');
    emit(const SettingScheduleSetState());
  }

  Future<void> onScheduleCancel(
    CancelScheduleEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(const SettingLoadingState());
    await AndroidAlarmManager.cancel(1);
    print('Alarm Canceled');
    await AppPreference.setNotif(false);
    emit(const SettingScheduleCanceltate());
  }
}
