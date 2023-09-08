# create ASG
resource "aws_autoscaling_group" "asg" {
  name = "${var.cluster_name}-asg"
  vpc_zone_identifier = data.aws_subnets.default.ids
  target_group_arns = [aws_lb_target_group.web_tg.arn]
  health_check_type = "ELB"

  min_size = var.cluster_min_size
  desired_capacity = 2
  max_size = var.cluster_max_size

  launch_template {
    name = "Apache"
  }

  tag {
    key = "Name"
    value = "${var.cluster_name}-instance"
    propagate_at_launch = true
  }
}