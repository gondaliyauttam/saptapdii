import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:saptapadi/model/CheckListModels/checkListtodoData.dart';
import 'package:saptapadi/model/CheckListModels/checklist_done.dart';
import 'package:saptapadi/model/success_data.dart';
import 'package:saptapadi/repository/user_repository.dart';

Future<CheckListTodoData> checklisttododata() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_checklist';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return checkListTodoDataFromJson(res);
  }
}

Future<SuccessData> adduserchecklist(id) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}add_user_checklist';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
      'checklist_id': id
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<SuccessData> removeuserchecklist(id) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}remove_checklist';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
      'checklist_id': id
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<SuccessData> addusercustomchecklist(text) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}add_user_custom_checklist';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
      'checklist_name': text
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<CheckListTodoData> checklistcustomtododata() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_user_custom_checklist';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return checkListTodoDataFromJson(res);
  }
}

Future<SuccessData> removeuserchecklistcustom(id) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}remove_user_custom_checklist';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
      'checklist_id': id
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<CheckListDoneData> checklistdonecustomdata() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_user_custome_checklist_done';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return checkListDoneDataFromJson(res);
  }
}

Future<SuccessData> addusercustomchecklistdone(id) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}add_user_custom_checklist_done';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
      'checklist_id': id
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<CheckListTodoData> checklistcustomalldata() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_user_custom_checklist_all';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return checkListTodoDataFromJson(res);
  }
}

Future<SuccessData> removeuserchecklistcustomdone(id) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}remove_user_custom_checklist_done';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
      'checklist_id': id
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<SuccessData> updateuserchecklistcustomtodo(id, name) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_user_custom_checklist_update';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
      'checklist_id': id,
      'checklist_name': name,
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<SuccessData> addvendorfinalised(vid) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}add_vendors_finalised';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
      'vid': vid
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}


Future<SuccessData> removevendorfinalised(vid) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}remove_vendors_finalised';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
      'vid': vid
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}
