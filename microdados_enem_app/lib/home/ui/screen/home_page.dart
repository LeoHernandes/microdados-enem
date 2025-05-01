import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microdados_enem_app/core/design_system/app_scaffold/app_scaffold.dart';
import 'package:microdados_enem_app/home/logic/participant_score_cubit.dart';
import 'package:microdados_enem_app/home/ui/widgets/subscription_number.dart';
import 'package:microdados_enem_app/home/ui/widgets/user_score_card/user_score_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarText: 'Início',
      selectedTab: NavTab.home,
      body: Column(
        children: [
          SubscriptionNumber(),
          SizedBox(height: 20),
          BlocProvider(
            create: (_) => ParticipantScoreCubit(),
            child: UserScoreCard(),
          ),
        ],
      ),
    );
  }
}
