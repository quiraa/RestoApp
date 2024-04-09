abstract class SettingEvent {
  const SettingEvent();
}

class CheckScheduleEvent extends SettingEvent {
  const CheckScheduleEvent();
}

class SetScheduleEvent extends SettingEvent {
  const SetScheduleEvent();
}

class CancelScheduleEvent extends SettingEvent {
  const CancelScheduleEvent();
}
