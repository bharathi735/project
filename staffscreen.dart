import 'package:flutter/material.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  Future getStaffDetails() async {
    final List staffs = [
      {
        "name": "Dr. S .vimala ",
        "job": "Associative Professor",
        "education":
            "M.Sc.(Computer Science), M.Phil(Computer Science)& Ph.D(CS)",
        "img": "assets/candidates/default.png"
      },
      {
        "name": "Dr. M. P. Indra Gandhi",
        "job": "Assistant Professor(SG)",
        "education": "B.Sc(Computer Science).,MCA,Ph.D(CS)",
        "img": "assets/candidates/default.png"
      },
      {
        "name": "D. Usha",
        "job": "Assistant Professor",
        "education": "MCA, M.Phil.(CS), M.Tech(CS), & Ph.D.(CS)",
        "img": "assets/candidates/default.png"
      },
      {
        "name": "Dr. V. Selvi",
        "job": "Assistant Professor",
        "education": "MCA,M.Phil.,Ph.D(CS)",
        "img": "assets/candidates/default.png"
      },
    ];

    await Future.delayed(const Duration(seconds: 2));
    return staffs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Details'),
        backgroundColor: const Color(0xFF1E40AF),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: FutureBuilder(
        future: getStaffDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No staff details available."));
          }

          final staffDetails = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: staffDetails.length,
            itemBuilder: (context, index) {
              final staff = staffDetails[index];
              return _buildStaffCard(
                  name: staff['name'] ?? 'N/A',
                  job: staff['job'] ?? 'N/A',
                  education: staff['education'] ?? 'N/A',
                  imgurl: staff['img']);
            },
          );
        },
      ),
    );
  }

  Widget _buildStaffCard({
    required String name,
    required String job,
    required String education,
    required String imgurl,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imgurl,
                width: 100,
                height: 100,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E40AF),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Job: $job',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Education: $education',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
