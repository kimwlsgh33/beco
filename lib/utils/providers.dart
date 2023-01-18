
import 'package:beco/cubits/auth_cubit.dart';
import 'package:beco/cubits/feed_cubit.dart';
import 'package:beco/cubits/pomo_cubit.dart';
import 'package:beco/cubits/wallet_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> blocProviders(context) => [
      BlocProvider<AuthCubit>(
        // 사용자 정보
        create: (context) => AuthCubit(),
        lazy: false,
      ),
      BlocProvider<PomoCubit>(
        create: (context) => PomoCubit(),
      ),
      BlocProvider<FeedCubit>(
        create: (context) => FeedCubit(),
      ),
      BlocProvider<WalletCubit>(
        create: (context) => WalletCubit(),
      ),
      BlocProvider<PomoCubit>(
        create: (context) => PomoCubit(),
      ),
    ];
