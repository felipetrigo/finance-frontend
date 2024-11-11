import 'package:financial_frontend/account/AccountDetail.dart';
import 'package:financial_frontend/client/QueryData.dart';
import 'package:financial_frontend/main.dart';
import 'package:flutter/material.dart';

import '../domain/customer.dart';

class AccountState extends State<AccountDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: super.widget.background,
      body: Center(
          child:
          FutureBuilder(future: QueryData.customerGet(), builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData){
              customer c = snapshot.requireData;
            return Column(children: [
                Image.asset("asset/img.png", scale: 2),
              Text(
              c.name,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'SourceSans',
                fontSize: 20.0,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.symmetric(
                        vertical: 11.0, horizontal: 24.0),
                    child: Row(children: [
                      const Icon(Icons.phone,
                          color: Colors.white),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Text(
                          c.phoneNumber,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'SourceSans',
                            fontSize: 20.0,
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.symmetric(
                        vertical: 11.0, horizontal: 24.0),
                    child: Row(children: [
                      const Icon(Icons.email,
                          color: Colors.white),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Text(
                          c.email,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'SourceSans',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            )
            ]);
            }else{
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
          },)

      ),
    );
  }
}
