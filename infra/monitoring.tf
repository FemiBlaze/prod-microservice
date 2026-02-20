resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/prod-microservice"
  retention_in_days = 7
}
resource "aws_sns_topic" "alerts" {
  name = "prod-microservice-alerts"
}
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "blaze2dtop@gmail.com"
}
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "prod-microservice-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.app.name
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
}
resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  alarm_name          = "prod-microservice-5xx-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 1

  dimensions = {
    LoadBalancer = aws_lb.app.arn_suffix
    TargetGroup  = aws_lb_target_group.app.arn_suffix
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
}
