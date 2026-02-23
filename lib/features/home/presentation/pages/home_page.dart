import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traffic_app/features/auth/domain/entities/user_entity.dart';
import 'package:traffic_app/features/auth/presentation/bloc/auth_state.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../data/data_sources/home_local_data.dart';
import '../widgets/donation_dialog.dart';
import '../widgets/menu_tile.dart';
import '../widgets/home_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = HomeLocalData.menuItems;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_sky.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  UserEntity? currentUser;
                  if (state is AuthAuthenticated) {
                    currentUser = state.user;
                  }
                  return HomeHeader(
                    user: currentUser,
                    onDonateTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const DonationDialog(),
                      );
                    },
                    onLoginTap: () {
                      if (currentUser != null) {
                        _showLogoutDialog(context);
                      } else {
                        Navigator.pushNamed(context, AppRoutes.login);
                      }
                    },
                  );
                },
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 1.5,
                        ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return MenuTile(
                        item: item,
                        onTap: () {
                          if (item.route != null) {
                            Navigator.pushNamed(
                                context,
                                item.route!,
                                arguments: {
                                  'isRandomMode': item.title.contains("Đề ngẫu nhiên"),
                                }
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Tính năng ${item.title} đang phát triển",
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    // Code hiện dialog đăng xuất
    // context.read<AuthBloc>().add(AuthLogoutRequested());
  }
}
