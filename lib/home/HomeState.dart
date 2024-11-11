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
  Color background = const Color.fromARGB(255, 110, 110, 110);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
          child: Column(children: [
        Container(
            color: Colors.lightGreen,
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: const Text("GASTOS",
                softWrap: true,
                style: TextStyle(fontSize: 20, color: Colors.white))),
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
                legendOptions: const LegendOptions(
                    legendTextStyle: TextStyle(color: Colors.white),
                    legendPosition: LegendPosition.bottom),
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
                  showDiag(background);
                },
                child: const Text(
                  "Adicionar Gasto",
                  style: TextStyle(color: Colors.white),
                ))),
        Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                ),
                onPressed: () {
                  updateDiag(background);
                },
                child: const Text(
                  "Alterar Gastos",
                  style: TextStyle(color: Colors.white),
                ))),
        Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Background color
                ),
                onPressed: () {
                  rmDiag(background);
                },
                child: const Text(
                  "Remover Gasto",
                  style: TextStyle(color: Colors.white),
                )))
      ])),
    );
  }

  Widget buildRemovable(Color background, Spent s) {
    return Container(
        color: background,
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
                child: Text(
              s.name,
              style: TextStyle(color: Colors.white),
            )),
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

  Widget buildUpdatableSpent(Spent s) {
    return Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(child: Text(s.name,style: TextStyle(color: Colors.white),)),
            Expanded(
                child: InkWell(
                    onTap: () {
                      setState(() {
                        formupdateDiag(background, s);
                      });
                    },
                    child: Icon(Icons.create_rounded, color: Colors.white)))
          ],
        ));
  }

  Future updateDiag(Color background) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
            backgroundColor: background,
            child: Center(
              child: Column(children: [
                const Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("ALTERAR DESPESAS",
                            softWrap: true, style: TextStyle(fontSize: 20,color: Colors.white)))),
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
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                      onPressed: cancel, child: const Text("VOLTAR")),
                )
              ]),
            )));
  }

  Future formupdateDiag(Color background, Spent s) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: background,
              title: const Text(
                "ALTERAR DESPESA",
                softWrap: true,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: "${s.name}"),
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
                    Text(
                      "Novo nome da despesa",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: "${s.price}"),
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
                    Text(
                      "Novo valor da despesa",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: cancel,
                    child: const Text("VOLTAR")),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: submitUpdate,
                    child: const Text("ENVIAR"))
              ],
            ));
  }

  Future rmDiag(Color background) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
            backgroundColor: background,
            child: Center(
              child: Column(children: [
                const Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("REMOVER DESPESAS",
                            softWrap: true,
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)))),
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
                                    return buildRemovable(background, s);
                                  });
                            } else {
                              return Container(
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator());
                            }
                          },
                        ))),
                Container(
                    padding: EdgeInsets.all(20),
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white)),
                        onPressed: cancel,
                        child: const Text("VOLTAR")))
              ]),
            )));
  }

  Future showDiag(Color background) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: background,
              title: const Text(
                "CADASTRAR DESPESAS",
                softWrap: true,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                          counterStyle: TextStyle(color: Colors.white),
                          hintText: "Nome",
                          hintStyle: TextStyle(color: Colors.white),
                          helperStyle: TextStyle(color: Colors.white)),
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
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          counterStyle: TextStyle(color: Colors.white),
                          hintText: "Valor",
                          hintStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white,
                          helperStyle: TextStyle(color: Colors.white)),
                      onSaved: (value) {
                        client.controllerMapping(
                            double.parse(value!.replaceAll(",", ".")));
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
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: cancel,
                    child: const Text("VOLTAR")),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: submit,
                    child: const Text("ENVIAR"))
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
