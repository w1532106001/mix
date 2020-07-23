import 'package:flutter/material.dart';
import 'file:///C:/Users/whc/flutter_code/mix/lib/common/mvpView.dart';

import '../res/dimens.dart';
import '../res/dimens.dart';

class BaseStatelessWidget extends StatelessWidget implements MvpView {
  const BaseStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  hideProgressDialog() {}

  @override
  showError() {
    return showErrorWithMessage("未知错误");
  }

  @override
  showErrorWithMessage(String message) {
    return Scaffold(
      body: Center(
        child: Text(
          message,
          style: TextStyle(color: Colors.black, fontSize: Dimens.font_sp18),
        ),
      ),
    );
  }

  @override
  showLoading() {
    return showLoadingWithMessage("正在加载中");
  }

  @override
  showLoadingWithMessage(String message) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
              padding: EdgeInsets.only(top: Dimens.gap_dp12),
              child: Text(
                message,
                style:
                    TextStyle(color: Colors.black, fontSize: Dimens.font_sp18),
              ))
        ],
      )),
    );
  }

  @override
  showMessage(String message) {}

  @override
  showProgressDialog(String message) {}
}
