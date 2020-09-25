import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:mix/viewModel/BaseViewModel.dart';
import 'package:mix/viewModel/LoginViewModel.dart';
import 'package:mix/viewModel/MineViewModel.dart';
import 'package:mix/viewModel/PersonViewModel.dart';
import 'package:mix/viewModel/VideoHomePageViewModel.dart';
import 'package:provider/provider.dart';
import 'package:mix/common/extension.dart';

class MineView extends BaseStatelessWidget {
  const MineView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 43, 42, 50),
          body: ChangeNotifierProvider(
            create: (_) => MineViewModel(),
            child: Consumer<MineViewModel>(
                builder: (_, mineViewModel, __) => ListView(
                  children: [
                    Container(
                      height: 120,
                      padding: EdgeInsets.only(left: 20,right: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage('https://dss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3922290090,3177876335&fm=26&gp=0.jpg'),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      height: 1,
                    ),//分割线
                    ListTile(
                      title: Text('收藏'),
                      leading: Icon(Icons.favorite),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: (){
                        Navigator.push(context, new MaterialPageRoute(builder: (_) {
                          return Container();
                        }));
                      },
                    ),
                    Divider(
                      color: Colors.white,
                      height: 1,
                    ),//分割线
                    ListTile(
                      title: Text('下载列表'),
                      leading: Icon(Icons.arrow_downward),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: (){
                        Navigator.push(context, new MaterialPageRoute(builder: (_) {
                          return Container();
                        }));
                      },
                    ),
                    Divider(
                      color: Colors.white,
                      height: 1,
                    ),//分割线
                    ListTile(
                      title: Text('退出账号'),
                      leading: Icon(Icons.person_outline),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: (){
                        Navigator.push(context, new MaterialPageRoute(builder: (_) {
                          return Container();
                        }));
                      },
                    ),
                    Divider(
                      color: Colors.white,
                      height: 1,
                    ),//分割线
                  ],
                )),
          ),
        ));
  }

  Widget _view(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final provider = Provider.of<MineViewModel>(context);
    switch (provider.state) {
      case 1:
        showProgressDialog(null);
        break;
      case 2:
        //请求成功拿到response 解析实体类
        provider.state = VideoModelState.notRequested;
        hideProgressDialog();
        BotToast.showSimpleNotification(title: "登录成功");


        break;
      case 3:
        provider.state = VideoModelState.notRequested;
        showMessage("网络异常");
    }


  }
}
