class WorkerRegisterController {
  Future<void> register() async {
    try {
      await Future.delayed(Duration(seconds: 3), () {
        print('done');
      });
    } catch (e) {
      throw "Đã có lỗi trong quá trình xử lý.";
    }
  }
}
