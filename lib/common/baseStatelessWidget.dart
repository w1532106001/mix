import 'package:flutter/material.dart';

import '../res/dimens.dart';
import 'mvpView.dart';

class BaseStatelessWidget extends StatelessWidget implements MvpView {
  const BaseStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  hideProgressDialog() {}

  @override
  Widget showError(bool isReload) {
    return showErrorWithMessage("网络异常",isReload);
  }

  @override
  Widget showErrorWithMessage(String message,bool isReload) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            message,
            style: TextStyle(color: Colors.black, fontSize: Dimens.font_sp18),
          ),
          Text(
            isReload?"点击重新加载":"",
            style: TextStyle(color: Colors.black, fontSize: Dimens.font_sp18),
          )
        ],
      ),
    );
  }

  @override
  Widget showLoading() {
    return showLoadingWithMessage("正在加载中");
  }

  @override
  Widget showLoadingWithMessage(String message) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        CircularProgressIndicator(),
        Padding(
            padding: EdgeInsets.only(top: Dimens.gap_dp12),
            child: Text(
              message,
              style: TextStyle(color: Colors.black, fontSize: Dimens.font_sp18),
            ))
      ],
    ));
  }

  @override
  showMessage(String message) {}

  @override
  showProgressDialog(String message) {}
}
