import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_users_app/core/theme/app_colors.dart';
import 'package:test_users_app/core/theme/app_text_styles.dart';
import 'package:test_users_app/modules/all_users/ui/bloc/all_users_bloc.dart';
import 'package:test_users_app/modules/all_users/ui/widgets/all_users_list_view.dart';
import 'package:flutter/material.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/shared_widgets/app_appbar.dart';
import '../../../../core/shared_widgets/loader.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _bloc = sl<AllUsersBloc>();

  @override
  void initState() {
    _bloc.add(GetAllUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: const AppAppbar(
          title: 'All Users',
        ),
        body: BlocProvider.value(
          value: _bloc,
          child: BlocBuilder<AllUsersBloc, AllUsersState>(
            builder: (context, state) {
              if (state is AllUsersLoadingState) {
                return const Loader();
              }
              if (state is AllUsersSuccessState) {
                return AllUsersListView(users: state.users);
              }
              if (state is AllUsersErrorState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Error'),
                      Text(state.errorText),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.cyan),
                          onPressed: () {
                            _bloc.add(GetAllUsersEvent());
                          },
                          child: Text(
                            'Reload',
                            style: AppTextStyles.subtitle,
                          ))
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ));
  }
}
