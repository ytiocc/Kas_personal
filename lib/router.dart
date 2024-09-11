import 'package:go_router/go_router.dart';
import 'package:kas_personal/screens/home_screen.dart';
import 'package:kas_personal/screens/kas_masuk_screen.dart';
import 'package:kas_personal/screens/kas_keluar_screen.dart';
import 'package:kas_personal/screens/rekap_kas_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'root',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'kas_masuk',
          name: 'kas_masuk',
          builder: (context, state) => const KasMasukScreen(),
        ),
        GoRoute(
          path: 'kas_keluar',
          name: 'kas_keluar',
          builder: (context, state) => const KasKeluarScreen(),
        ),
         GoRoute(
          path: 'rekap_kas',
          name: 'rekap_kas',
          builder: (context, state) => const RekapKasScreen(),
        ),
      ],
    ),
  ],
);