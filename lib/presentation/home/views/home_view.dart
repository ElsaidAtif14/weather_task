import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/presentation/home/cubit/weather_cubit.dart';
import 'package:weather/presentation/home/views/widgets/custom_text_field.dart';
import 'package:weather/presentation/home/views/widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<WeatherCubit>().getWeather();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch([String? typedQuery]) {
  final query = (typedQuery ?? _searchController.text).trim();
  if (query.isNotEmpty) {
    context.read<WeatherCubit>().getWeather(cityName: query);
    _searchController.clear();
  }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFFF8A71).withOpacity(0.4),
                const Color(0xFFFF8A71).withOpacity(0.2),
                const Color(0xFF00576E).withOpacity(0.2),
                const Color(0xFF00576E).withOpacity(0.4),
              ],
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CustomTextField(
                  onSubmitted:_onSearch,
                  controller: _searchController,
                  hintText: 'Search city...',
                  prefixIcon: Icons.location_on,
                  suffixIcon: Icons.search,
                  onSuffixTap: _onSearch,
                ),
                const SizedBox(height: 16),
                const HomeViewBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
