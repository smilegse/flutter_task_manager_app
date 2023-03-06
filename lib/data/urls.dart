class Urls {
  static String baseUrl = 'https://task.teamrabbil.com/api/v1';

  static String loginUrl = '$baseUrl/login';
  static String registrationUrl = '$baseUrl/registration';
  static String createTaskUrl = '$baseUrl/createTask';
  static String newTaskUrl = '$baseUrl/listTaskByStatus/New';
  static String completedTaskUrl = '$baseUrl/listTaskByStatus/Completed';

  static String changeTaskStatusUrl(String taskId, String status) =>
      '$baseUrl/updateTaskStatus/$taskId/$status';
}
