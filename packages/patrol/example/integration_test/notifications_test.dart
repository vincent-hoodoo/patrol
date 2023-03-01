import 'common.dart';

void main() {
  patrol(
    'taps on notification',
    ($) async {
      await createApp($);
      await $('Open notifications screen').tap();

      if (await $.native.isPermissionDialogVisible()) {
        await $.native.grantPermissionWhenInUse();
      }

      await $('Show in a few seconds').tap();
      await $.native.pressHome();
      await $.native.openNotifications();

      // wait for notification to show up
      await Future<void>.delayed(const Duration(seconds: 5));

      final notifications = await $.native.getNotifications();
      for (final notification in notifications) {
        print(
          'Notification from ${notification.appName}: ${notification.title}',
        );
      }

      await $.native.tapOnNotificationBySelector(
        Selector(textContains: 'Someone liked'),
      );

      await $('Tapped notification with ID: 1').waitUntilVisible();
    },
  );
}
