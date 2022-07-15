class ChangeFavourites {
  final bool status;
  final String message;

  ChangeFavourites({
    required this.status,
    required this.message,
  });

  factory ChangeFavourites.fromJson(dynamic json) {
    return ChangeFavourites(
      status: json['status'],
      message: json['message'],
    );
  }
}
