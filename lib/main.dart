import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Text Painter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(
        title: 'Flutter Text Painter',
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            CommentWidget(
              label: 'Comentário Pequeno',
              text: smallText,
            ),
            SizedBox(
              height: 20,
            ),
            CommentWidget(
              label: 'Comentário Grande',
              text: bigText,
            ),
          ],
        ),
      ),
    );
  }
}

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
    required this.label,
    required this.text,
  });

  final String label;
  final String text;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  //Podemos fazer um getter para o texto
  String get _text => widget.text;

  //Defina quantas linhas serão exibidas;
  final maxLines = 4;

  //Defina a largura máxima;
  final maxWidth = 400.0;

  //Defina uma variável de controle;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    //Converta seu texto em Span;
    final span = TextSpan(
      text: widget.text,
    );

    //Utilize o Text Painter
    final textPainter = TextPainter(
      maxLines: maxLines,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      text: span,
    )..layout(maxWidth: maxWidth);

    //Método para sabermos se o Texto é maior que o MaxLines;
    final exceeded = textPainter.didExceedMaxLines;

    return Column(
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        isExpanded
            ? SizedBox(
                width: maxWidth,
                child: Text(
                  _text,
                ),
              )
            : SizedBox(
                width: maxWidth,
                child: Text(
                  _text,
                  maxLines: maxLines,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
        if (exceeded)
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child:
                isExpanded ? const Text('Ver menos') : const Text('Ver mais'),
          ),
      ],
    );
  }
}

const bigText =
    'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?';

const smallText =
    'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.';
