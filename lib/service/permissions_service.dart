import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  Future<bool> askPermission(Permission permission) async {
   var status = await permission.request();
   if(status != PermissionStatus.granted) {
     return false;
   }

   return true;
  }
}