import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class CategoriesScreen extends StatefulWidget {
  final int initialIndex;

  const CategoriesScreen({super.key, this.initialIndex = 0});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 90,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset(
            'assets/route_logo.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Text(
              'Route',
              style: TextStyle(color: Color(0xff004182), fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: const Color(0xff004182).withOpacity(0.3)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Color(0xff004182)),
                        SizedBox(width: 8),
                        Text(
                          "what do you search for?",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.shopping_cart_outlined, color: Color(0xff004182), size: 28),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xff004182)),
            );
          }

          if (state is HomeError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is HomeSuccess) {
            final allProducts = state.products;

            final dynamicCategories = allProducts
                .map((product) => product.categoryName?.trim() ?? 'General')
                .toSet()
                .toList();

            if (_selectedIndex >= dynamicCategories.length) {
              _selectedIndex = 0;
            }

            final currentCategorySelected = dynamicCategories[_selectedIndex];

            final filteredProducts = allProducts.where((product) {
              return (product.categoryName?.trim() ?? 'General') == currentCategorySelected;
            }).toList();

            return Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.32,
                  color: const Color(0xffF4F6F9),
                  child: ListView.builder(
                    itemCount: dynamicCategories.length,
                    itemBuilder: (context, index) {
                      final isSelected = index == _selectedIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              if (isSelected)
                                Container(
                                  width: 4,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff004182),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              if (isSelected) const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  dynamicCategories[index],
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: const Color(0xff06283D),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentCategorySelected,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff06283D),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage('assets/banner_bg.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                currentCategorySelected,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff004182),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text("Shop Now", style: TextStyle(color: Colors.white, fontSize: 12)),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: filteredProducts.isEmpty 
                            ? const Center(child: Text('No products here'))
                            : GridView.builder(
                                itemCount: filteredProducts.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.58,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 12,
                                ),
                                itemBuilder: (context, index) {
                                  final product = filteredProducts[index];

                                  String cleanImageUrl = product.imageUrl ?? '';
                                  if (cleanImageUrl.startsWith('[')) {
                                    cleanImageUrl = cleanImageUrl
                                        .replaceAll('[', '')
                                        .replaceAll(']', '')
                                        .replaceAll('"', '')
                                        .trim();
                                  }

                                  if (!cleanImageUrl.startsWith('http')) {
                                    cleanImageUrl = 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500';
                                  }

                                  return Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            cleanImageUrl,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            errorBuilder: (context, error, stackTrace) {
                                              return  Container(
                                                color: Color(0xffF4F6F9),
                                                child: Icon(Icons.broken_image, color: Colors.grey),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        product.title ?? "Product",
                                        style: const TextStyle(fontSize: 11, color: Color(0xff06283D)),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  );
                                },
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: Text('No Data Available'),
          );
        },
      ),
    );
  }
}