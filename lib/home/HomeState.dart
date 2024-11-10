import 'package:financial_frontend/home/HomeDetail.dart';

import 'package:financial_frontend/client/QueryData.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../domain/Spent.dart';

class HomeState extends State<HomeDetail> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  QueryData client = QueryData();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        Container(
            color: Colors.lightGreen,
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child:
                const Text("GASTOS", softWrap: true, style: TextStyle(fontSize: 20,color: Colors.white))),
        FutureBuilder<Map<String, double>>(
          future: QueryData.listSpents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Expanded(
                  child: PieChart(
                dataMap: snapshot.requireData,
                baseChartColor: Colors.grey,
                chartValuesOptions: ChartValuesOptions(
                    showChartValuesInPercentage: true,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                )),
                legendOptions:
                    const LegendOptions(legendPosition: LegendPosition.bottom),
              ));
            } else {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
          },
        ),
        Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                ),
                onPressed: () {
                  showDiag();
                },
                child: const Text("Adicionar Gasto", style: TextStyle(color: Colors.white),))),
        Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                ),
                onPressed: () {
                  updateDiag();
                },
                child: const Text("Alterar Gastos", style: TextStyle(color: Colors.white),))),
        Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
                ),
                onPressed: () {
                  rmDiag();
                },
                child: const Text("Remover Gasto", style: TextStyle(color: Colors.white),)))
        
      ])),
    );
  }

  Widget buildRemovable(Spent s) {
    return Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(child: Text(s.name)),
            Expanded(
                child: InkWell(
                    onTap: () {
                      setState(() {
                        QueryData.deleteSpents(context, s.id);
                      });
                    },
                    child: Icon(Icons.close, color: Colors.red)))
          ],
        ));
  }
  Widget buildUpdatableSpent(Spent s){
    return Container(padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(child: Text(s.name)),
            Expanded(
                child: InkWell(
                    onTap: () {
                      setState(() {
                        formupdateDiag(s);
                      });
                    },
                    child: Icon(Icons.create_rounded, color: Colors.black)))
          ],
        ));
  }
  Future updateDiag() {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
                child: Center(
              child: Column(children: [
                const Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("ALTERAR DESPESAS",
                            softWrap: true, style: TextStyle(fontSize: 20)))),
                Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: FutureBuilder(
                          future: QueryData.listarSpents(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.requireData.length,
                                  itemBuilder: (context, index) {
                                    Spent s = snapshot.requireData[index];
                                    return buildUpdatableSpent(s);
                                  });
                            } else {
                              return Container(
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator());
                            }
                          },
                        ))),
                Expanded(
                  child: TextButton(
                      onPressed: cancel, child: const Text("VOLTAR")),
                )
              ]),
            )));
  }
    Future formupdateDiag(Spent s) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                "ALTERAR DESPESA",
                softWrap: true,
                style: TextStyle(fontSize: 20),
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    TextFormField(
                      decoration: InputDecoration(hintText: "${s.name}"),
                      onSaved: (value) {
                        client.controllerUpdateMapping(s.id);
                        client.controllerUpdateMapping(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor envie o nome da nova despesa';
                        }
                        return null;
                      },
                    ),
                    Text("Novo nome da despesa"),
                    
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "${s.price}"),
                      onSaved: (value) {
                        client.controllerUpdateMapping(s.percentage);
                        client.controllerUpdateMapping(double.parse(value!));
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor envie o valor da nova despesa';
                        }
                        return null;
                      },
                    ),
                    Text("Novo valor da despesa"),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: cancel, child: const Text("VOLTAR")),
                TextButton(onPressed: submitUpdate, child: const Text("ENVIAR"))
              ],
            ));
  }
  Future rmDiag() {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
                child: Center(
              child: Column(children: [
                const Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("REMOVER DESPESAS",
                            softWrap: true, style: TextStyle(fontSize: 20)))),
                Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: FutureBuilder(
                          future: QueryData.listarSpents(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.requireData.length,
                                  itemBuilder: (context, index) {
                                    Spent s = snapshot.requireData[index];
                                    return buildRemovable(s);
                                  });
                            } else {
                              return Container(
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator());
                            }
                          },
                        ))),
                Expanded(
                  child: TextButton(
                      onPressed: cancel, child: const Text("VOLTAR")),
                )
              ]),
            )));
  }

  Future showDiag() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                "CADASTRAR DESPESAS",
                softWrap: true,
                style: TextStyle(fontSize: 20),
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(hintText: "Nome"),
                      onSaved: (value) {
                        client.controllerMapping(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor envie o nome da nova despesa';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: "Valor"),
                      onSaved: (value) {
                        client.controllerMapping(double.parse(value!.replaceAll(",", ".")));
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor envie o valor da nova despesa';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: cancel, child: const Text("VOLTAR")),
                TextButton(onPressed: submit, child: const Text("ENVIAR"))
              ],
            ));
  }

  void cancel() {
    Navigator.of(context).pop();
  }
  void submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      Navigator.pop(context);
      client.putSpent();
    }
  }
  void submitUpdate() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      Navigator.pop(context);
      client.updateSpents();
    }
  }
}
