import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/features/home/presentation/views/splash_view.dart';
import 'features/home/data/models/movie_model.dart';
import 'features/home/presentation/manager/watchlist_cubit.dart';
import 'features/home/presentation/manager/search_cubit.dart';
import 'features/home/data/data_sources/home_remote_data_source.dart';
import 'features/home/presentation/manager/home_cubit.dart';
// ignore: unused_import
import 'package:movie_app/features/home/presentation/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(MovieModelAdapter());
  }

  await Hive.openBox<MovieModel>('watchlist_box');

  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    final remoteDataSource = HomeRemoteDataSource();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(remoteDataSource)..fetchHomeData(),
        ),
        BlocProvider(create: (context) => WatchlistCubit()..getWatchlist()),
        BlocProvider(create: (context) => SearchCubit(remoteDataSource)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF242A32),
          primaryColor: const Color(0xFF0296E5),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF242A32),
            elevation: 0,
            centerTitle: true,
          ),
        ),
        home: const SplashView(),
      ),
    );
  }
}
