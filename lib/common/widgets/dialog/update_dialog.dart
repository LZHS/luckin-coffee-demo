import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luckin_coffee_demo/common/common.dart';
import 'package:luckin_coffee_demo/data_provider/data_provider.dart';
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class UpdateDialog extends Dialog {
  final AppInfo appInfo;
  final VoidCallback onTap;

  UpdateDialog({@required this.appInfo, this.onTap})
      : assert(appInfo != null);
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
      onWillPop: _onNavigationClickEvent,
      child: Material(
        type: MaterialType.transparency,
        child: _buildContentView(),
      ),
    );
  }

  Future<bool> _onNavigationClickEvent() async {
      return Future.value(false);
  }

  Future<void> closeApp() async {
    await SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }

  _buildContentView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)))),
          margin: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildTitleWidget(),
              DividerWidget(),
              _buildContentWidget(),
              _buildActionWidget()
            ],
          ),
        ),
      ),
    );
  }

  _buildActionWidget() => Visibility(
//    visible: noticeInfo.enabledStatus,
    visible: true,
        child: Container(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            alignment: Alignment.center,
            child: AppButton(
              text: "知道了",
              width: 130,
              onTap: () {
                onTap?.call();
                Navigator.of(context).pop();
              },
            )),
      );

  _buildContentWidget() => ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: double.infinity, minHeight: 100.0, maxHeight: 260.0),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Text(
              "${_buildInfoContext(appInfo.appDescription)}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  fontSize: 13.0,
                  color: AppColors.appTextColor),
            ),
          ),
        ),
      );

  _buildTitleWidget() => Container(
        padding: const EdgeInsets.only(top: 18.0, bottom: 14.0),
        child: Text(
          "${appInfo.appVersion} 更新",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: AppColors.appTitleColor),
        ),
      );

  String _buildInfoContext(appDescription) {
    List<String> arr=appDescription.split(RegExp("<br/>"));
    String result="";
    arr.forEach((element)=> result+="\n$element");
    return result;

  }
}
