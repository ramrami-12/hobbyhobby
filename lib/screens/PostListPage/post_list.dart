// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostListPage extends StatelessWidget {
  dynamic comData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(comData);

    return Scaffold(
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
// 미션 팝업창 
// 댓글 페이지
