
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mix/ui/view/login_view.dart';
import 'package:mix/ui/view/videoHomePage.dart';
import 'package:mix/viewModel/BaseViewModel.dart';
import 'package:provider/provider.dart';
import 'package:mix/common/extension.dart';

import '../res/dimens.dart';
import 'VideoModelState.dart';
import 'mvpView.dart';

class BaseStatelessWidget extends StatelessWidget implements MvpView {
  const BaseStatelessWidget({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BaseViewModel>(context);
    switch (provider.state) {
      case 1:
        return showLoading();
      case 2:
      //用户为空跳转登录页 不为空跳转主页
        if(provider.currentUser==null){
//          Navigator.push(context, new MaterialPageRoute(
//              builder: (_) {
                return new LoginView();
//              }));
        }else{
//          Navigator.push(context, new MaterialPageRoute(
//              builder: (_) {
                return new VideoHomePage();
//              }));
        }
        break;
      case 3:
        return GestureDetector(
          child: showError(true),
          onTap: () => {
            provider.state = VideoModelState.notRequested,
            provider.getUserCache()
          },
        );
    }
    return Container();
  }

  @override
  hideProgressDialog() {
    BotToast.closeAllLoading();
  }

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
  showMessage(String message) {
    BotToast.showSimpleNotification(
      title: message
    );
  }

  @override
  showProgressDialog(String message) {
    BotToast.showLoading(
      duration: null,
      clickClose: false,
      allowClick: false,
    );
  }
}
