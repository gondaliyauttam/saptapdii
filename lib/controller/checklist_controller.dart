import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/CheckListModels/checkListtodoData.dart';
import 'package:saptapadi/model/CheckListModels/checklist_done.dart';
import 'package:saptapadi/model/success_data.dart';
import 'package:saptapadi/repository/check_repository.dart';
import 'package:saptapadi/route/route_argument.dart';
import 'package:saptapadi/utils/constants.dart';

class CheckController extends ControllerMVC {
  List<CheckList> checklisttodo = new List<CheckList>();
  List<CheckList> checklistall = new List<CheckList>();
  List<CheckList> checklistdone = new List<CheckList>();
  GlobalKey<ScaffoldState> scaffoldKey;
  List<CheckList> checklistCustomtodo = new List<CheckList>();
  List<CheckList> checklistCustomall = new List<CheckList>();
  List<ChecklistDone> checklistCustomdone = new List<ChecklistDone>();
  TextEditingController itemname = new TextEditingController();

  CheckController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  getCheckLitdatatodo() async {
    checklisttodo.clear();
    CheckListTodoData checkListData = await checklisttododata();
    if (checkListData.statusCode == 1) {
      checklistall = checkListData.checkList;
      all = checklistall.length;
      checkListData.checkList.forEach((element) {
        if (element.checklistDone == "") {
          checklisttodo.add(element);
        } else {
          checklistdone.add(element);
          done = checklistdone.length;
        }

        setState(() {});

        print(checklisttodo.length);
      });
    }
  }

  addUserCheckList(id) async {
    SuccessData successData = await adduserchecklist(id);
    if (successData.statusCode == 1) {
      checklisttodo.removeWhere((element) => element.id == id);
      checklistall.forEach((element) {
        if (element.id == id) {
          element.checklistDone = "yes";
          checklistdone.add(element);
        }
      });

      done = done + 1;

      notifyListeners();
    }
    BotToast.showText(text: successData.msg);
  }

  removeUserCheckList(id) async {
    SuccessData successData = await removeuserchecklist(id);
    if (successData.statusCode == 1) {
      checklistdone.removeWhere((element) => element.id == id);
      checklistall.forEach((element) {
        if (element.id == id) {
          element.checklistDone = "";
          checklisttodo.add(element);
        }
      });
      done = done - 1;
      notifyListeners();
    }
    BotToast.showText(text: successData.msg);
  }

  addUserCustomCheckList(msg) async {
    SuccessData successData = await addusercustomchecklist(msg);
    if (successData.statusCode == 1) {
      BotToast.showText(text: successData.msg);
      setState(() {
        itemname.text = "";
      });
      Navigator.of(context).pushNamed('/CustomCheckList');
    }
  }

  getCheckLitdatacustomtodo() async {
    checklistCustomtodo.clear();
    CheckListTodoData checkListData = await checklistcustomtododata();
    if (checkListData.statusCode == 1) {
      checklistCustomtodo = checkListData.checkList;
      setState(() {});
      print(checklistCustomtodo.length);
    }
  }

  addUserCustomCheckListdone(id) async {
    SuccessData successData = await addusercustomchecklistdone(id);
    if (successData.statusCode == 1) {
      checklistCustomtodo.removeWhere((element) => element.checklistId == id);
      notifyListeners();
      getCheckLitdatacustomdone();
      getCheckLitdatacustomall();
    }

    BotToast.showText(text: successData.msg);
  }

  removeUserCheckListCustom(id) async {
    SuccessData successData = await removeuserchecklistcustom(id);
    if (successData.statusCode == 1) {
      checklistCustomtodo.removeWhere((element) => element.checklistId == id);
      getCheckLitdatacustomdone();
      getCheckLitdatacustomall();
      Navigator.of(context).pop(true);
    }
    BotToast.showText(text: successData.msg);
  }

  getCheckLitdatacustomdone() async {
    CheckListDoneData checkListDoneData = await checklistdonecustomdata();
    if (checkListDoneData.statusCode == 1) {
      checklistCustomdone = checkListDoneData.checklistDone;
      customDone = checklistCustomdone.length;
      print(checklistCustomdone.length);
      setState(() {});
    }
  }

  getCheckLitdatacustomall() async {
    checklistCustomall.clear();
    CheckListTodoData checkListData = await checklistcustomalldata();
    if (checkListData.statusCode == 1) {
      setState(() {
        checklistCustomall = checkListData.checkList;
        customAll = checklistCustomall.length;
      });
    }
  }

  removeUserCustomCheckListDone(id) async {
    SuccessData successData = await removeuserchecklistcustomdone(id);
    if (successData.statusCode == 1) {
      checklistCustomdone.removeWhere((element) => element.checklistId == id);
      customDone = customDone - 1;

      getCheckLitdatacustomtodo();
      getCheckLitdatacustomall();
    }
    BotToast.showText(text: successData.msg);
  }

  updateUserCustomCheckListtodo(id, name) async {
    SuccessData successData = await updateuserchecklistcustomtodo(id, name);
    BotToast.showText(text: successData.msg);
  }

  openEditPage(id, name) async {
    var result = await Navigator.of(context).pushNamed('/AddCheckList',
        arguments: new RouteArgument(id: id, fromStart: false, heroTag: name));
    if (result == true) {
      getCheckLitdatacustomtodo();
      getCheckLitdatacustomall();
    }
  }
}
