import 'dart:io';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:komikcast/env.dart';

final Email emailModel = Email(
  subject: "${Platform.isAndroid ? 'Android' : 'Ios'}-Feedback",
  isHTML: false,
  recipients: [Env.email],
);
