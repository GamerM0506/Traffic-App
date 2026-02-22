class TrafficSignHelper {
  static String translateCategory(String englishCategory) {
    switch (englishCategory) {
      case 'PROHIBITION':
        return 'Biển báo cấm';
      case 'DANGER':
        return 'Biển báo nguy hiểm';
      case 'COMMAND':
        return 'Biển hiệu lệnh';
      case 'INSTRUCTION':
        return 'Biển chỉ dẫn';
      case 'AUXILIARY':
        return 'Biển phụ';
      case 'MARKING':
        return 'Vạch kẻ đường';
      default:
        return 'Khác';
    }
  }
}
