import 'package:rmservice/place_page/models/rental_place.dart';

List<RentalPlace> testListRentalPlace = [
  RentalPlace(
    id: 1,
    name: "Người cho thuê 1",
    phone: "0123456789",
    titleRent: "Cho thuê 1",
    numOfDayRent: 2,
    area: 55,
    price: 2400000,
    description: "Nhà cho thuê 1 với diện tích rộng",
    images: [
      'assets/images/location.png',
      'assets/images/location.png',
      'assets/images/location.png'
    ],
    address: "227 Nguyễn Văn Cừ, Phải 4, Quận 5, TPHCM, VietnamNam",
    latitude: 10.88372,
    longitude: 106.7833329,
    createdAt: DateTime.now(),
    expiredAt: DateTime.now().add(Duration(days: 30)),
  ),
  RentalPlace(
    id: 2,
    name: "Người cho thuê 2",
    phone: "0123456789",
    titleRent: "Cho thuê 2",
    numOfDayRent: 2,
    area: 55,
    price: 2400000,
    description: "Nhà cho thuê 2  với diện tích rộng",
    images: [
      'assets/images/location.png',
      'assets/images/location.png',
      'assets/images/location.png'
    ],
    address: "Làng Đại học Quốc gia TPHCM",
    latitude: 10.8843172,
    longitude: 106.7830829,
    createdAt: DateTime.now(),
    expiredAt: DateTime.now().add(Duration(days: 24)),
  ),
  RentalPlace(
    id: 3,
    name: "Người cho thuê  3",
    phone: "0123456789",
    titleRent: "Cho thuê 3",
    numOfDayRent: 2,
    area: 55,
    price: 2400000,
    description: "Nhà cho thuê 3 với diện tích rộng",
    images: [
      'assets/images/location.png',
      'assets/images/location.png',
      'assets/images/location.png'
    ],
    address: "Làng Đại học Quốc gia TPHCM",
    latitude: 10.8799496,
    longitude: 106.7805717,
    createdAt: DateTime.now(),
    expiredAt: DateTime.now().add(Duration(days: 14)),
  ),
  RentalPlace(
    id: 4,
    name: "Người cho thuê 4",
    phone: "0123456789",
    titleRent: "Cho thuê 4",
    numOfDayRent: 2,
    area: 55,
    price: 2400000,
    description: "Nhà cho thuê 4 với diện tích rộng",
    images: [
      'assets/images/location.png',
      'assets/images/location.png',
      'assets/images/location.png'
    ],
    address: "Làng Đại học Quốc gia TPHCM",
    latitude: 10.8651747,
    longitude: 106.7727565,
    createdAt: DateTime.now(),
    expiredAt: DateTime.now().add(Duration(days: 7)),
  ),
];
