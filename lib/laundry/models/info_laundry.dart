class InfoLaundry {
  int clothes;
  int blanket;
  int mosquito;
  int net;
  int drap;
  int topper;
  int pillow;
  int comple;
  int vietnamDress;
  int weedingDress;
  int bleaching;
  bool isOnPeakDate;
  bool isOnPeakHour;
  bool isOnHoliday;
  bool isOnWeekend;
  int totalPrice;
  DateTime? sendDate;
  DateTime? sendTime;
  DateTime? receiveDate;
  DateTime? receiveTime;
  String note;
  String paymentMethod;

  InfoLaundry({
    this.clothes = 0,
    this.blanket = 0,
    this.mosquito = 0,
    this.net = 0,
    this.drap = 0,
    this.topper = 0,
    this.pillow = 0,
    this.comple = 0,
    this.vietnamDress = 0,
    this.weedingDress = 0,
    this.bleaching = 0,
    this.isOnPeakDate = false,
    this.isOnPeakHour = false,
    this.isOnHoliday = false,
    this.isOnWeekend = false,
    this.totalPrice = 0,
    this.sendDate,
    this.sendTime,
    this.receiveDate,
    this.receiveTime,
    this.note = '',
    this.paymentMethod = 'PAYMENT_METHOD_CASH'
  });
}