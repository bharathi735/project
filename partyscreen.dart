import 'package:e_voting_app/candidatelist.dart';
import 'package:e_voting_app/firestore.dart';
import 'package:flutter/material.dart';

class PartyScreen extends StatefulWidget {
  final String phoneNumber; // User's phone number to track voting.

  const PartyScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<PartyScreen> createState() => _PartyScreenState();
}

class _PartyScreenState extends State<PartyScreen> {
  bool iscanvotenow = false;

  @override
  void initState() {
    super.initState();
    getIsPoll().then((value) {
      setState(() {
        iscanvotenow = value ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Positions'),
        backgroundColor: const Color(0xFF1E40AF),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: iscanvotenow
            ? SingleChildScrollView(
                child: FutureBuilder(
                  future: getvotedposition(widget.phoneNumber),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                          child: Text("Error: ${snapshot.error}",
                              style: const TextStyle(color: Colors.red)));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No voting data found."));
                    }

                    // Fetch data safely
                    List<dynamic> VotedPositions = [];
                    var data =
                        snapshot.data!.docs[0].data() as Map<String, dynamic>;
                    if (data.containsKey('VotedPositions')) {
                      VotedPositions = data['VotedPositions'];
                    }

                    return Column(
                      children: [
                        PartyCard(
                          i: 0,
                          phoneNumber: widget.phoneNumber,
                          VotedPositions: VotedPositions,
                          position: "President",
                        ),
                        PartyCard(
                          i: 1,
                          phoneNumber: widget.phoneNumber,
                          VotedPositions: VotedPositions,
                          position: "Vice president",
                        ),
                        PartyCard(
                          i: 2,
                          phoneNumber: widget.phoneNumber,
                          VotedPositions: VotedPositions,
                          position: "Treasurer",
                        ),
                        PartyCard(
                          i: 3,
                          phoneNumber: widget.phoneNumber,
                          VotedPositions: VotedPositions,
                          position: "Coordinator",
                        ),
                        PartyCard(
                          i: 4,
                          phoneNumber: widget.phoneNumber,
                          VotedPositions: VotedPositions,
                          position: "Secretary",
                        ),
                        PartyCard(
                          i: 5,
                          phoneNumber: widget.phoneNumber,
                          VotedPositions: VotedPositions,
                          position: "Join Secretary",
                        ),
                      ],
                    );
                  },
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 6,
                  color: Colors.red[100], // Light red background for error
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red, // Red icon for error
                          size: 30,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "No Poll has started yet!",
                            style: TextStyle(
                              color: Colors.red[800], // Dark red text color
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class PartyCard extends StatefulWidget {
  final int i;
  final String position;
  final String phoneNumber;
  final List VotedPositions;

  const PartyCard({
    super.key,
    required this.position,
    required this.phoneNumber,
    required this.VotedPositions,
    required this.i,
  });

  @override
  _PartyCardState createState() => _PartyCardState();
}

class _PartyCardState extends State<PartyCard> {
  bool voted = false;

  @override
  void initState() {
    super.initState();
    voted = widget.VotedPositions.contains(widget.position);
  }

  void _rebuild() {
    setState(() {
      voted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.position,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E40AF),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: voted
                        ? null
                        : () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Candidatelist(
                                callback: () {
                                  _rebuild(); // Call rebuild when the user confirms the vote
                                },
                                position: widget.position,
                                phoneNumber: widget.phoneNumber,
                                voted: voted,
                              ),
                            ));
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E40AF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(voted ? "Already Voted" : "Vote Now"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
