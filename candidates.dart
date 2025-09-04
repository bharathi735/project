final candidates = [
  {
    "name": "Muthu Priya M",
    "rollno": "20222BC1",
    "img": "assets/candidates/1.jpg"
  },
  {"name": "Indhuja S", "rollno": "2022BC13", "img": "assets/candidates/2.jpg"},
  {"name": "Janane S", "rollno": "2022BC14", "img": "assets/candidates/3.jpg"},
  {
    "name": "Jeevajothi M",
    "rollno": "2022BC15",
    "img": "assets/candidates/4.jpg"
  },
  //coordinates
  {
    "name": "Kamatchi R",
    "rollno": "2022BC16",
    "img": "assets/candidates/5.jpg"
  },
  {"name": " Rahima J", "rollno": "2022BC17", "img": "assets/candidates/6.jpg"},
  {"name": "kaviya R", "rollno": "2022BC18", "img": "assets/candidates/7.jpg"},
  {
    "name": "Krishna Priya M",
    "rollno": "2022BC19",
    "img": "assets/candidates/8.jpg"
  },
  //join secretary
  {"name": "Lavanya N", "rollno": "2022BC20", "img": "assets/candidates/9.jpg"},
  {
    "name": "Mahalakshmi B",
    "rollno": "2022BC21",
    "img": "assets/candidates/10.jpg"
  },
  {"name": "keerthi R", "rollno": "2022BC18", "img": "assets/candidates/2.jpg"},
  {
    "name": " Mohana K",
    "rollno": "2022BC22",
    "img": "assets/candidates/11.jpg"
  },
  //president
  {
    "name": "Maria Christina Jefrin B",
    "rollno": "2022BC23",
    "img": "assets/candidates/12.jpg"
  },
  {"name": "Maha S", "rollno": "2023BC25", "img": "assets/candidates/13.jpg"},
  {
    "name": "Mohana Sankari V M S",
    "rollno": "2023BC26",
    "img": "assets/candidates/14.jpg"
  },
  {
    "name": "Neemath Sharfah I",
    "rollno": "2023BC27",
    "img": "assets/candidates/15.jpg"
  },
  //secretary
  {
    "name": "Nivetha S",
    "rollno": "2023BC28",
    "img": "assets/candidates/16.jpg"
  },
  {
    "name": "Oritha ezihlarasi J",
    "rollno": "2023BC29",
    "img": "assets/candidates/17.jpg"
  },
  {
    "name": "Priya Dharshini P",
    "rollno": "2023BC30",
    "img": "assets/candidates/18.jpg"
  },
  {"name": "Aswini A", "rollno": "2023BC12", "img": "assets/candidates/19.jpg"},
  //treasurer
  {
    "name": "lakshmi B V",
    "rollno": "2023BC13",
    "img": "assets/candidates/20.jpg"
  },
  {
    "name": "Dharshini G",
    "rollno": "2023BC14",
    "img": "assets/candidates/21.jpg"
  },
  {
    "name": "Ferdolina Roselin S",
    "rollno": "2023BC15",
    "img": "assets/candidates/22.jpg"
  },
  {
    "name": "Gana Shree S",
    "rollno": "2023BC16",
    "img": "assets/candidates/23.jpg"
  },
  //vice president
];

String? getImagePath(String id) {
  try {
    // Find the image path by matching the name
    for (var candidate in candidates) {
      if (candidate["rollno"] == id) {
        return candidate["img"] ?? "assets/candidates/default.png";
      }
    }
    // Return the image path if found
    return "assets/candidates/default.png";
  } catch (e) {
    return "assets/candidates/default.png"; // Default image in case of error
  }
}

Map getcandiadates(String roll) {
  try {
    // Find the image path by matching the name
    for (var candidate in candidates) {
      if (candidate["rollno"] == roll) {
        return {"name": candidate["name"]!, "img": candidate["img"]!};
      }
    }
    // return null;
    // Return the image path if found
    return {"rollno": "N/A", "img": "assets/candidates/default.png"};
  } catch (e) {
    return {"rollno": "N/A", "img": "assets/candidates/default.png"};
    // Default image in case of error
  }
}
