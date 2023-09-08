# create ALB
resource "aws_lb" "web" {
  name = "${var.cluster_name}-alb"
  load_balancer_type = "application"
  internal = false
  
  security_groups = data.aws_security_groups.apache.ids
  subnets = data.aws_subnets.default.ids
}

# create ALB listener
resource "aws_lb_listener" "web_http" {
  protocol = local.http_protocol
  port = local.http_port
  load_balancer_arn = aws_lb.web.arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: Not found"
      status_code = 404
    }
  }
}

# create target group
resource "aws_lb_target_group" "web_tg" {
  name = "${var.cluster_name}-tg"
  protocol = local.http_protocol
  port = local.http_port
  vpc_id = data.aws_vpc.default.id

  health_check {
    path = "/"
    protocol = local.http_protocol
    port = local.http_port
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

# ALB listener rule
resource "aws_lb_listener_rule" "web_http_rule" {
  listener_arn = aws_lb_listener.web_http.arn
  priority = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}