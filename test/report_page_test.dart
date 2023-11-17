import 'package:flutter_test/flutter_test.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/friend_interactions_api_provider.dart';
import 'package:im_okay/Services/API%20Services/Friend%20Interaction%20Service/mock_friend_interactions_api_service.dart';
import 'package:im_okay/pages/reports_page.dart';

void main() async {
  IFriendInteractionsProvider mockFriendInteractionsProvider =
      MockFriendInteractionsApiService();
  testWidgets('Reports page has a user list and a button', (tester) async {
    await tester.pumpWidget(ReportsPage(
      friendInteractionProvider: mockFriendInteractionsProvider,
    ));
  });
}
