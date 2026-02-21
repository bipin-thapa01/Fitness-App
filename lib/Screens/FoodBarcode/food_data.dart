import 'package:flutter/material.dart';

class FoodData extends StatefulWidget {
  final Map<String, dynamic> product;
  const FoodData({super.key, required this.product});

  @override
  State<FoodData> createState() => _FoodDataState();
}

class _FoodDataState extends State<FoodData> {
  String _formatNutrient(dynamic value) {
    final parsed = double.tryParse(value.toString());
    return parsed != null ? parsed.toStringAsFixed(1) : '0';
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            ),
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product['image'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[600],
                  child: const Icon(Icons.image_not_supported, size: 60),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['brand'] ?? 'Unknown Brand',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['category'] ?? '',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Nutrition Facts',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),

                  Row(
                    children: [
                      _NutritionCard(
                        label: 'Protein',
                        value: _formatNutrient(product['protein']),
                        unit: 'g',
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 12),
                      _NutritionCard(
                        label: 'Carbs',
                        value: _formatNutrient(product['carbs']),
                        unit: 'g',
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 12),
                      _NutritionCard(
                        label: 'Fat',
                        value: _formatNutrient(product['fat']),
                        unit: 'g',
                        color: Colors.red,
                      ),
                      const SizedBox(width: 12),
                      _NutritionCard(
                        label: 'Sugar',
                        value: _formatNutrient(product['sugar']),
                        unit: 'g',
                        color: Colors.purple,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Serving Info',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  _InfoRow('Serving Size', product['serving_size']),
                  _InfoRow('Serving Quantity', product['serving_quantity']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NutritionCard extends StatelessWidget {
  final String label;
  final dynamic value;
  final String unit;
  final Color color;

  const _NutritionCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              '$value$unit',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _InfoRow(String label, dynamic value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Text(
          value?.toString() ?? 'Unknown',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    ),
  );
}
