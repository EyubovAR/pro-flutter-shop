import 'package:flutter/material.dart';
import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  final List<String> categories = ['Все', 'Ноутбуки', 'Клавиатуры', 'Аудио', 'Мониторы'];
  final List<IconData> categoryIcons = [
    Icons.apps,
    Icons.laptop,
    Icons.keyboard,
    Icons.headset,
    Icons.tv,
  ];

  // Список товаров с локальными картинками из assets/images/ (Урок 12)
  final List<ProductWithCategory> allProducts = const [
    ProductWithCategory(
      categoryIndex: 1, // Ноутбуки
      product: Product(
        title: 'Игровой ноутбук 17.3"',
        description: 'Мощный процессор, экран 165 Гц',
        price: '550 000 ₸',
        imageUrl: 'assets/images/noutbook.jpg',
      ),
    ),
    ProductWithCategory(
      categoryIndex: 2, // Клавиатуры
      product: Product(
        title: 'Мех. клавиатура',
        description: 'Линейные свитчи, RGB',
        price: '42 000 ₸',
        imageUrl: 'assets/images/klava.jpg',
      ),
    ),
    ProductWithCategory(
      categoryIndex: 3, // Аудио
      product: Product(
        title: 'Наушники ANC',
        description: 'Шумоподавление, 30ч работы',
        price: '35 000 ₸',
        imageUrl: 'assets/images/naushniki.jpg',
      ),
    ),
    ProductWithCategory(
      categoryIndex: 4, // Мониторы
      product: Product(
        title: 'Монитор 27" 2K',
        description: 'IPS матрица, 1 мс',
        price: '135 000 ₸',
        imageUrl: 'assets/images/monitor.jpg',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Фильтрация товаров по выбранной категории
    final displayedProducts = _selectedCategoryIndex == 0
        ? allProducts
        : allProducts.where((item) => item.categoryIndex == _selectedCategoryIndex).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        title: const Text('Tech Store', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Промо-баннер
            Container(
              margin: const EdgeInsets.all(16),
              height: 140,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Скидки до -40%',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Топовые девайсы для работы и игр по суперценам',
                    style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 12),
                  ),
                ],
              ),
            ),

            // 2. Интерактивные категории
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Категории',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF6366F1) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Colors.transparent : Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            categoryIcons[index],
                            size: 14,
                            color: isSelected ? Colors.white : Colors.grey[700],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            categories[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Популярное',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 10),

            // 3. Сетка товаров
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayedProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final product = displayedProducts[index].product;
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/detail', arguments: product);
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                // Использование локальной картинки через Image.asset (Урок 12)
                                child: Image.asset(
                                  product.imageUrl,
                                  height: 95,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    product.price,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.title,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    product.description,
                                    style: TextStyle(color: Colors.grey[500], fontSize: 10),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
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
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class ProductWithCategory {
  final int categoryIndex;
  final Product product;

  const ProductWithCategory({
    required this.categoryIndex,
    required this.product,
  });
}