import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/local_storage.dart';
import 'package:microdados_enem_app/home/logic/participant_score.cubit.dart';
import 'package:microdados_enem_app/home/logic/participant_score_state.dart';
import 'package:microdados_enem_app/home/ui/widgets/user_score_card/card_body.dart';
import 'package:microdados_enem_app/home/ui/widgets/user_score_card/card_body_error.dart';
import 'package:microdados_enem_app/home/ui/widgets/user_score_card/card_body_loading.dart';
import 'package:provider/provider.dart';

class UserScoreCard extends HookWidget {
  const UserScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    final localStorage = Provider.of<LocalStorage>(context, listen: false);
    final subscription = localStorage.getString(StorageKeys.subscription, '');

    useEffect(() {
      context.read<ParticipantScoreCubit>().getParticipantScoreData(
        subscription,
      );
      return () {};
    }, []);

    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.whitePrimary,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackLightest,
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),

      child: BlocBuilder<ParticipantScoreCubit, ParticipantScoreState>(
        builder:
            (context, state) => state.when(
              isIdle: CardBodyLoading.new,
              isLoading: CardBodyLoading.new,
              isError:
                  (_) => CardBodyError(
                    refetch:
                        () => context
                            .read<ParticipantScoreCubit>()
                            .getParticipantScoreData(subscription),
                  ),
              isSuccess: (data) => CardBody(participantScore: data),
            ),
      ),
    );
  }
}
