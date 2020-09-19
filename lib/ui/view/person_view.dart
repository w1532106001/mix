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
import 'package:mix/viewModel/PersonViewModel.dart';
import 'package:mix/viewModel/VideoHomePageViewModel.dart';
import 'package:provider/provider.dart';
import 'package:mix/common/extension.dart';

class PersonView extends BaseStatelessWidget {
  final int personId;

  const PersonView(this.personId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 43, 42, 50),
          body: ChangeNotifierProvider(
            create: (_) => PersonViewModel(this.personId),
            child: Consumer<PersonViewModel>(
                builder: (_, personVideoModel, __) => _view(_)),
          ),
        ));
  }

  Widget _view(BuildContext context) {
    final provider = Provider.of<PersonViewModel>(context);
    switch (provider.state) {
      case 1:
        return showLoading();
      case 2:
        //请求成功拿到response 解析实体类
        if (provider.response.code == 0) {
          var person = Person.fromJson(provider.response.data);
          return ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              PersonIntroductionWidget(person),
              Container(
                child: Text(
                  "视频",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimens.font_sp24,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              PersonVideoListWidget(person)
            ],
          );
        } else {
          return GestureDetector(
            child: showErrorWithMessage(provider.response.message, true),
            onTap: () => {
              provider.state = VideoModelState.notRequested,
              provider.getPersonData()
            },
          );
        }
        break;
      case 3:
        return GestureDetector(
          child: showError(true),
          onTap: () => {
            provider.state = VideoModelState.notRequested,
            provider.getPersonData()
          },
        );
    }
  }
}
