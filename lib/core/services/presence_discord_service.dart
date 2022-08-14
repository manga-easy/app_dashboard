import 'package:dart_discord_rpc/dart_discord_rpc.dart';
import 'package:dashboard_manga_easy/core/interfaces/service.dart';

class PresenceDiscordService implements IService {
  DiscordRPC rpc = DiscordRPC(
    applicationId: '899061153001533510',
  );
  bool inicialization = false;
  final int timestamp = DateTime.now().millisecondsSinceEpoch;
  @override
  Future<void> initialise() async {}

  void updatePresence(String page) {
    if (!inicialization) {
      rpc.start(autoRegister: true);
      inicialization = true;
    }
    rpc.updatePresence(
      DiscordPresence(
        state: 'Dashboard Mangá Easy',
        details: page,
        startTimeStamp: timestamp,
      ),
    );
  }
}
