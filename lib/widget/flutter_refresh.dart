import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_mall/res/color.dart';

typedef Widget TransitionBuilder(
    BuildContext context, Widget child, ScrollController scrollController);

class FlutterRefresh extends EasyRefresh {
  static final _refreshHeader = MaterialHeader(
    key: new GlobalKey<RefreshHeaderState>(),
  );
  static final _refreshFooter = BallPulseFooter(
    key: new GlobalKey<RefreshFooterState>(),
    color: primarySwatchColor,
  );

  FlutterRefresh(
      {GlobalKey<EasyRefreshState> key,
      ScrollBehavior behavior,
      RefreshHeader refreshHeader,
      RefreshFooter refreshFooter,
      Widget firstRefreshWidget,
      Widget emptyWidget,
      AnimationStateChanged animationStateChangedCallback,
      HeaderStatusChanged headerStatusChanged,
      FooterStatusChanged footerStatusChanged,
      HeaderHeightChanged headerHeightChanged,
      FooterHeightChanged footerHeightChanged,
      OnRefresh onRefresh,
      LoadMore loadMore,
      bool autoLoad: true,
      bool limitScroll: false,
      bool autoControl: true,
      bool firstRefresh: false,
      ScrollController outerController,
      TransitionBuilder builder,
      @required Widget child})
      : super(
            key: key,
            behavior: behavior,
            refreshHeader: refreshHeader == null ? _refreshHeader : null,
            refreshFooter: refreshFooter == null ? _refreshFooter : null,
            firstRefreshWidget: firstRefreshWidget,
            emptyWidget: emptyWidget,
            animationStateChangedCallback: animationStateChangedCallback,
            headerStatusChanged: headerStatusChanged,
            footerStatusChanged: footerStatusChanged,
            headerHeightChanged: headerHeightChanged,
            footerHeightChanged: footerHeightChanged,
            onRefresh: onRefresh,
            loadMore: loadMore,
            autoLoad: autoLoad,
            limitScroll: limitScroll,
            autoControl: autoControl,
            firstRefresh: firstRefresh,
            outerController: outerController,
            builder: builder,
            child: child);
}
