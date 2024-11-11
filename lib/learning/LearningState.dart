import 'package:financial_frontend/learning/LearningDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Learning.dart';
import 'LearningDescription.dart';

class LearningState extends State<LearningDetail> {
  List<Learning> list = [
    Learning(
        "CDB",
        "O Certificado de Depósito Bancário (CDB) é um dos investimentos de renda fixa mais populares entre os investidores.\n\nIsso se deve principalmente à rentabilidade e segurança. Por isso, se tornou uma ótima opção para pessoas físicas, que estão trocando os investimentos em poupança pelo CDB, que vem se mostrando mais atrativo.\n\nNeste artigo, abordaremos como funciona o CDB, quais suas vantagens e como começar a investir nesse tipo de ativo de forma segura.\n\nO que é CDB?\n\nO Certificado de Depósito Bancário (CDB) é um investimento de renda fixa emitido pelos bancos com o objetivo de captar recursos para financiar suas atividades, como projetos, crescimento e pagamento de dívidas.\nQualquer investidor pode adquirir um CDB.  E esse tipo de investimento conta com a proteção do Fundo Garantidor de Créditos (FGC) com limite de R\$250 mil por CPF ou CNPJ em cada instituição ou conglomerado financeiro, limitado ao saldo existente.\nDevido a essa proteção, o CDB é considerado um investimento de renda fixa com baixo risco, pois, caso o banco emissor não consiga honrar o pagamento, o FGC reembolsará o investidor até o limite estabelecido.\n\nComo funciona o CDB?\n\n" +
            "O CDB funciona como um empréstimo do seu dinheiro para uma instituição bancária e, em troca, você recebe uma taxa de rentabilidade que é definida no momento da compra.\nAssim, ao adquirir um CDB, você está emprestando dinheiro ao banco emissor por um determinado prazo. Em troca, o banco paga juros sobre o valor investido.\nAo final do prazo estabelecido, o investidor recebe de volta o valor investido mais os juros acordados.\nO investimento de renda fixa em CDB pode ser feito através de bancos ou corretoras de valores. No entanto, nas corretoras de valores, você pode contar com inúmeras alternativas de CDBs e taxas de rentabilidade maiores.",
        "RICO"),
    Learning(
        "Renda Fixa",
        "O que é Renda Fixa e por que investir?" +
            "A Renda Fixa é uma modalidade de investimento para quem procura segurança e bons retornos. O investimento é realizado diretamente em Títulos Públicos e Privados de Renda Fixa. Por exemplo, quando você compra um título, está emprestando dinheiro ao emissor do papel, que pode ser um banco, uma empresa ou até mesmo o governo. Em troca, recebe uma remuneração após um determinado prazo com juros e/ou correção monetária, podendo ainda receber parcelas chamadas amortizações.\nInvestindo em produtos de Renda Fixa na XP, você tem acesso a uma plataforma exclusiva para operar Títulos Públicos, CDBs, LCIs, CRIs, CRAs, LCAs e Debêntures de maneira diferenciada. Dentro da plataforma, também poderá se informar melhor a respeito dos produtos disponíveis, comprar e vender com total autonomia, transparência e agilidade, além de administrar sua carteira com segurança. Tudo isso em poucos cliques, na tela do computador ou no celula",
        "XP investimentos"),
    Learning(
        "O que são ações",
        "Ações são valores mobiliários emitidos por sociedades anônimas representativos de uma parcela do seu capital social. Em outras palavras, são títulos de propriedade que conferem a seus detentores (investidores) a participação na sociedade da empresa.\nElas são emitidas por empresas que desejam principalmente captar recursos para desenvolver projetos que viabilizem o seu crescimento.\nAs ações podem ser de dois tipos, ordinárias ou preferenciais, sendo que a principal diferença é que as ordinárias dão ao seu detentor direito de voto nas assembleias de acionistas e as preferenciais permitem o recebimento de dividendos em valor superior ao das ações ordinárias, bem como a prioridade no recebimento de reembolso do capital.\nO primeiro lançamento de ações no mercado é chamado de Oferta Pública Inicial (também conhecido pela sigla em inglês IPO – Initial Public Offer). Após a abertura de capital e a oferta inicial, a empresa poderá realizar outras ofertas públicas, conhecidas como “Follow on”.\nAs ofertas públicas de ações (IPO e Follow on) podem ser primárias e/ou secundárias. Nas ofertas primárias, a empresa capta recursos novos para investimento e reestruturação de passivos, ou seja, ocorre efetivamente um aumento de capital da empresa. As ofertas secundárias, por sua vez, proporcionam liquidez aos empreendedores, que vendem parte de suas ações, num processo em que o capital da empresa permanece o mesmo, porém ocorre um aumento na base de sócios\nA B3 criou segmentos especiais de listagem da companhias – Bovespa Mais, Bovespa Mais Nível 2, Novo Mercado, Nível 2 e Nível 1. Todos os segmentos prezam por rígidas regras de governança corporativa. Essas regras vão além das obrigações que as companhias têm perante a Lei das Sociedades por Ações e têm como objetivo melhorar a avaliação das companhias que decidem aderir, voluntariamente, a um desses níveis de listagem.\nAlém disso, tais regras atraem os investidores. Ao assegurar direitos e garantias aos acionistas, bem como a divulgação de informações mais completas para controladores, gestores da companhia e participantes do mercado, o risco é reduzido.",
        "B3")
  ];

  @override
  Widget build(BuildContext context) {
    Color background = super.widget.background;
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Column(
          children: [
            Text('APRENDER', style: TextStyle(color: Colors.white)),
            for (var it in list)
              Container(
                  color: background,
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.lightGreen)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LearningDescription(background,it)));
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(children: [
                          const Icon(Icons.play_arrow, color: Colors.white),
                          Text(it.title,
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.white))
                        ])),
                  ))
          ],
        ),
      ),
    );
  }
}
