import 'package:stackfood_multivendor/common/enums/data_source_enum.dart';
import 'package:stackfood_multivendor/features/notification/domain/models/my_notification_model.dart';
import 'package:stackfood_multivendor/features/notification/domain/models/notification_model.dart';
import 'package:stackfood_multivendor/features/notification/domain/service/notification_service_interface.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor/util/images.dart';

class MyNotificationController extends GetxController {
  List<MyNotificationModel> notifications = [
    MyNotificationModel(
      id: 1,
      orderName: "order",
      date: "19 aug,2024",
      time: "12:25 PM",
      imageUrl: Images.notification,
      status: 'your order 515478 is delivered',
    ),
    MyNotificationModel(
      id: 1,
      orderName: "order",
      date: "19 aug,2024",
      time: "12:25 PM",
      imageUrl: Images.notifications2,
      status: 'your order 515478 is delivered',
    ),
    MyNotificationModel(
      id: 1,
      orderName: "order",
      date: "19 aug,2024",
      time: "12:25 PM",
      imageUrl: Images.notifications2,
      status: 'your order 515478 is delivered',
    ),
    MyNotificationModel(
      id: 1,
      orderName: "order",
      date: "19 aug,2024",
      time: "12:25 PM",
      imageUrl: Images.notifications2,
      status: 'your order 515478 is delivered',
    ),
  ];
}

class NotificationController extends GetxController implements GetxService {
  final NotificationServiceInterface notificationServiceInterface;
  NotificationController({required this.notificationServiceInterface});

  List<NotificationModel>? _notificationList;
  List<NotificationModel>? get notificationList => _notificationList;

  bool _hasNotification = false;
  bool get hasNotification => _hasNotification;

  Future<void> getNotificationList(bool reload,
      {DataSourceEnum dataSource = DataSourceEnum.local,
      bool fromRecall = false}) async {
    if (_notificationList == null || reload || fromRecall) {
      _notificationList = null;

      List<NotificationModel>? notificationList;
      if (dataSource == DataSourceEnum.local) {
        notificationList = await notificationServiceInterface.getList(
            source: DataSourceEnum.local);
        _prepareNotificationList(notificationList);
        getNotificationList(false,
            dataSource: DataSourceEnum.client, fromRecall: true);
      } else {
        notificationList = await notificationServiceInterface.getList(
            source: DataSourceEnum.client);
        _prepareNotificationList(notificationList);
      }
    }
  }

  _prepareNotificationList(List<NotificationModel>? notificationList) {
    if (notificationList != null) {
      _notificationList = notificationList;
      _hasNotification =
          _notificationList!.length != getSeenNotificationCount();
    }
    update();
  }

  void saveSeenNotificationCount(int count) {
    notificationServiceInterface.saveSeenNotificationCount(count);
  }

  int? getSeenNotificationCount() {
    return notificationServiceInterface.getSeenNotificationCount();
  }

  void clearNotification() {
    _notificationList = null;
  }

  void addSeenNotificationId(int id) {
    List<int> idList = [];
    idList.addAll(notificationServiceInterface.getNotificationIdList());
    idList.add(id);
    notificationServiceInterface.addSeenNotificationIdList(idList);
    update();
  }

  List<int>? getSeenNotificationIdList() {
    return notificationServiceInterface.getNotificationIdList();
  }
}
