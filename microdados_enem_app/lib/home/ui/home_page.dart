import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microdados_enem_app/home/logic/home_page_cubit.dart';
import 'package:microdados_enem_app/home/logic/home_page_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomePageStateCubit(),
      child: const Foobar(),
    );
  }
}

class Foobar extends StatelessWidget {
  const Foobar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Boas vindas!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/onboarding/step1.png')),
            const Text(
              'A quantidade de linhas na tabela:',
              style: TextStyle(
                fontFamily: 'Rawline',
                fontWeight: FontWeight.w900,
              ),
            ),
            BlocBuilder<HomePageStateCubit, HomePageState>(
              builder: (context, state) {
                return state.when(
                  isIdle:
                      () => Text(
                        'Parado',
                        style: TextStyle(
                          fontFamily: 'Rawline',
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  isLoading: () => Text('Carregando'),
                  isError: Text.new,
                  isSuccess: (data) => Text('${data.count}'),
                );
              },
            ),
          ],
        ),
      ),
      // TODO: change this to a call in a useEffect using flutter hooks
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<HomePageStateCubit>().getHomePageData(),
        key: const Key('Foobar'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
