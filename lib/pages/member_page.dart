import 'package:flutter/material.dart';

///会员中心
class MemberPage extends StatefulWidget {
  @override
  MemberPageState createState() => MemberPageState();
}

class MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: Text('会员中心'),
    );
  }
}
