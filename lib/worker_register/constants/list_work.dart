class Job {
  int id;
  String name;
  
  Job(this.id, this.name);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

List<Job> listJobsTest = [ 
  Job(1, "Dọn dẹp nhà cửa"),
  Job(2, "Nấu ăn tại gia"),
  Job(3, "Vệ sinh máy lạnh"),
  Job(4, "Đi chợ"),
  Job(5, "Giặt ủi")
];
