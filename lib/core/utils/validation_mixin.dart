mixin ValidationMixin {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Vui lòng nhập Email';
    if (!value.contains('@')) return 'Email không hợp lệ';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 6)
      return 'Mật khẩu phải ít nhất 6 ký tự';
    return null;
  }
}
