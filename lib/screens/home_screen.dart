// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hotel_provider.dart';
import '../widgets/hotel_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  String selectedCategory = "All"; // Track selected category

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<HotelProvider>(context, listen: false).fetchHotels();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context);
    final allHotels = hotelProvider.hotels;

    // Filter logic: Search + Category
    final displayHotels = allHotels.where((h) {
      final matchesSearch = h.name.toLowerCase().contains(searchController.text.toLowerCase()) ||
          h.location.toLowerCase().contains(searchController.text.toLowerCase());
      // For now, category is illustrative; if your Hotel model has a 'category' field, use:
      // final matchesCategory = selectedCategory == "All" || h.category == selectedCategory;
      return matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      body: hotelProvider.isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF002366)))
          : CustomScrollView(
        slivers: [
          // 1. STICKY PREMIUM HEADER
          SliverAppBar(
            expandedHeight: 100,
            pinned: true,
            backgroundColor: const Color(0xFF002366),
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true, // This is the magic line
              titlePadding: EdgeInsets.only(bottom: 25), // Use only bottom padding to align with the back button if needed
              title: Text(
                "HomeStays",
                style: TextStyle(
                  fontFamily: 'HomeStayFont',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // 2. SEARCH & CATEGORIES SECTION
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (v) => setState(() {}),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search, color: Color(0xFF002366)),
                        hintText: "Search by city or hotel...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Categories Header
                  const Text("Categories",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF002366))),
                  const SizedBox(height: 12),

                  // Horizontal Category Chips
                  SizedBox(
                    height: 45,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategoryChip("All"),
                        _buildCategoryChip("Luxury"),
                        _buildCategoryChip("Resort"),
                        _buildCategoryChip("Mountain"),
                        _buildCategoryChip("Beach"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Nearby Section Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Near Your Location",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF002366))),
                      TextButton(
                          onPressed: () {},
                          child: const Text("See on Map", style: TextStyle(color: Color(0xFFB8860B))) // Gold accent
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 3. THE "ALL HOTELS" LIST
          // Using SliverPadding to keep the list away from the screen edges
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, i) => HotelCard(hotel: displayHotels[i]),
                childCount: displayHotels.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    bool isSelected = selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => selectedCategory = label),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF002366) : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
          boxShadow: isSelected ? [BoxShadow(color: const Color(0xFF002366).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}