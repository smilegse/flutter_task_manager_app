class Urls {
  static String baseUrl = 'https://task.teamrabbil.com/api/v1';

  static String loginUrl = '$baseUrl/login';
  static String registrationUrl = '$baseUrl/registration';
  static String createTaskUrl = '$baseUrl/createTask';
  static String deleteTaskUrl(String taskId) => '$baseUrl/deleteTask/$taskId';
  static String taskStatusCountUrl = '$baseUrl/taskStatusCount';

  static String newTaskUrl = '$baseUrl/listTaskByStatus/New';
  static String completedTaskUrl = '$baseUrl/listTaskByStatus/Completed';
  static String progressTaskUrl = '$baseUrl/listTaskByStatus/Progress';
  static String cancelledTaskUrl = '$baseUrl/listTaskByStatus/Cancelled';

  static String profileUpdateUrl = '$baseUrl/profileUpdate';

  static String changeTaskStatusUrl(String taskId, String status) =>
      '$baseUrl/updateTaskStatus/$taskId/$status';


}
