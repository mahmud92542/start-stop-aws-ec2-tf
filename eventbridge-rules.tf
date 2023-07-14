resource "aws_cloudwatch_event_rule" "sgp-uat-cw-rule-start-ec2" {
    name = "sgp-uat-cw-rule-start-ec2"
    description = "Trigger Lambda function to start EC2 instances"
    schedule_expression = "cron(*/2 * * * ? *)"
}


resource "aws_cloudwatch_event_rule" "sgp-uat-cw-rule-stop-ec2" {
    name = "sgp-uat-cw-rule-stop-ec2"
    description = "Trigger Lambda function to stop EC2 instances"
    schedule_expression = "cron(*/10 * * * ? *)"
}


resource "aws_cloudwatch_event_target" "sgp-uat-lbd-start-ec2" {
    arn = aws_lambda_function.sgp-uat-lbd-start-stop-ec2.arn
    rule = aws_cloudwatch_event_rule.sgp-uat-cw-rule-start-ec2.name
    input = <<JSON
    {
        "operation":"start"
    }
JSON
}

resource "aws_cloudwatch_event_target" "sgp-uat-lbd-stop-ec2" {
    arn = aws_lambda_function.sgp-uat-lbd-start-stop-ec2.arn
    rule = aws_cloudwatch_event_rule.sgp-uat-cw-rule-stop-ec2.name
    input = <<JSON
    {
        "operation":"stop"
    }
JSON
}

resource "aws_lambda_permission" "start-permission" {
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.sgp-uat-lbd-start-stop-ec2.arn
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.sgp-uat-cw-rule-start-ec2.arn
}

resource "aws_lambda_permission" "stop-permission" {
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.sgp-uat-lbd-start-stop-ec2.arn
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.sgp-uat-cw-rule-stop-ec2.arn
}