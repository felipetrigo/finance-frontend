import 'package:financial_frontend/account/AccountState.dart';
import 'package:flutter/widgets.dart';

class AccountDetail extends StatefulWidget{
  Color background;
  AccountDetail({required this.background});
  @override
  State<StatefulWidget> createState() => AccountState();
}