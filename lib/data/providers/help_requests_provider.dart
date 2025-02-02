import 'package:volunteen/data/enums/help_category.dart';
import 'package:volunteen/data/models/help_request.dart';

class VolunteenHelpRequestsProvider {
  final List<HelpRequest> helpRequests = [];

  VolunteenHelpRequestsProvider() {
    helpRequests.addAll([
      HelpRequest(
        id: '1',
        title: 'طلب مساعدة ١',
        description: 'هذا وصف مفصل لطلب المساعدة الأول.',
        category: HelpCategory.childCare,
        location: 'القاهرة',
        locationInDetails: 'وسط المدينة، شارع التحرير',
        day: 'الأحد',
        hour: '١٢:٠٠ ظهرًا',
        phoneNumber: '٠١٠١٢٣٤٥٦٧٨',
        whatsAppNumber: '٠١١٢٣٤٥٦٧٨٩',
        requestedUserId: 'user_1',
        helpingUserId: null,
      ),
      HelpRequest(
        id: '2',
        title: 'طلب مساعدة ٢',
        description: 'هذا وصف مفصل لطلب المساعدة الثاني.',
        category: HelpCategory.delivery,
        location: 'الإسكندرية',
        locationInDetails: 'منطقة محطة الرمل',
        day: 'الإثنين',
        hour: '٤:٠٠ عصرًا',
        phoneNumber: '٠١٢٣٤٥٦٧٨٩٠',
        whatsAppNumber: '٠١٥٦٧٨٩٠١٢٣',
        requestedUserId: 'user_2',
        helpingUserId: 'helper_1',
      ),
    ]);
  }

  List<HelpRequest> getHelpRequests() {
    return helpRequests;
  }
}
