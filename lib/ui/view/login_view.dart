import 'package:flutter/material.dart';
import 'package:mix/common/VideoModelState.dart';
import 'package:mix/common/baseStatelessWidget.dart';
import 'package:mix/entity/person.dart';
import 'package:mix/model/collection.dart';
import 'package:mix/model/video_home_page_data.dart';
import 'package:mix/res/dimens.dart';
import 'package:mix/ui/widget/person_introduction_widget.dart';
import 'package:mix/ui/widget/person_video_list_widget.dart';

import 'package:mix/ui/widget/videoBannerWidget.dart';
import 'package:mix/ui/widget/videoHorizontalList.dart';
import 'package:mix/viewModel/LoginViewModel.dart';
import 'package:mix/viewModel/PersonViewModel.dart';
import 'package:mix/viewModel/VideoHomePageViewModel.dart';
import 'package:provider/provider.dart';
import 'package:mix/common/extension.dart';

class LoginView extends BaseStatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 43, 42, 50),
          body: ChangeNotifierProvider(
            create: (_) => LoginViewModel(),
            child: Consumer<LoginViewModel>(
                builder: (_, personVideoModel, __) => _view(_)),
          ),
        ));
  }

  Widget _view(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final provider = Provider.of<LoginViewModel>(context);
    GlobalKey _formKey = new GlobalKey<FormState>();
    TextEditingController _usernameController = new TextEditingController();
    TextEditingController _pwdController = new TextEditingController();
    return Container(
      padding: EdgeInsets.all(10),
      child: Form(
        key: _formKey, //设置globalKey，用于后面获取FormState
        autovalidate: true, //开启自动校验
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
                autofocus: true,
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "用户名或邮箱",
                    icon: Icon(Icons.person)),
                // 校验用户名
                validator: (v) {
                  return v.trim().length > 0 ? null : "用户名不能为空";
                }),
            TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "您的登录密码",
                    icon: Icon(Icons.lock)),
                obscureText: true,
                //校验密码
                validator: (v) {
                  return v.trim().length > 5 ? null : "密码不能少于6位";
                }),
            // 登录按钮
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          //在这里不能通过此方式获取FormState，context不对
                          //print(Form.of(context));

                          // 通过_formKey.currentState 获取FormState后，
                          // 调用validate()方法校验用户名密码是否合法，校验
                          // 通过后再提交数据。
                          if ((_formKey.currentState as FormState).validate()) {
                            //验证通过提交数据
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("注册"),
                        color: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {
                          //在这里不能通过此方式获取FormState，context不对
                          //print(Form.of(context));

                          // 通过_formKey.currentState 获取FormState后，
                          // 调用validate()方法校验用户名密码是否合法，校验
                          // 通过后再提交数据。
                          if ((_formKey.currentState as FormState).validate()) {
                            //验证通过提交数据
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
