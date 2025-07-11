import 'package:flutter/material.dart';

import 'event_list_widget.dart';

class EventBodyWidget extends StatelessWidget {
  const EventBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: EventNotificationListWidget()
    );
  }
}
