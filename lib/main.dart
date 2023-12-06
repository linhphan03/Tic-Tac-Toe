import 'package:flutter/material.dart';
import 'package:tictactoe/tictactoe.dart';
import 'package:flutter/services.dart';

final imageMap = {
  Player.x: Image.asset('assets/images/x.png'),
  Player.o: Image.asset('assets/images/o.png')
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

//stateless: dont change (images)
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  //override createState -> return state of MyHomePage object
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _gameState = TicTacToeState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        //center everything inside it
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 100.0, 
              minHeight: 120.0
            ),
            child: AspectRatio(
              aspectRatio: 5 / 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    // sized to fill available horizontal/vertical space
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Stack(children: [
                        Image.asset('assets/images/grid.png'),
                        GridView.builder(
                          itemCount: TicTacToeState.numCells,
                          gridDelegate: 
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: TicTacToeState.size),
                          itemBuilder: (context, index) {
                            return TextButton(
                              onPressed: () => _processPress(index),
                              child: imageMap[_gameState.board[index]] ??
                                Container(),
                            );
                          })
                        ]
                      )),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              _gameState.getStatus(),
                              style: const TextStyle(fontSize: 36),
                            ),
                          ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: _resetGame,
                          child: const Text(
                            'Reset',
                            style: TextStyle(fontSize: 36),
                          ),
                        )
                      ]),
                    )
                ],
              ),
            ),
        )));
  }

  void _processPress(int index) {
    setState(() {
      _gameState.playAt(index);
    });
  }

  void _resetGame() {
    setState(() {
      _gameState.reset();
    });
  }
}
