data "archive_file" "zip_the_python_code" {
    type        = "zip"
    source_dir  = "${path.module}/start_stop_lambda_function/"
    output_path = "${path.module}/start_stop_lambda_function/start_stop_lambda_function.zip"
}


resource "aws_lambda_function" "sgp-uat-lbd-start-stop-ec2" {
    filename                       = "${path.module}/start_stop_lambda_function/start_stop_lambda_function.zip"
    function_name                  = "sgp-uat-lbd-start-stop-ec2"
    role                           = aws_iam_role.sgp-uat-role-lbd-start-stop-ec2.arn
    handler                        = "start_stop_lambda_function.lambda_handler"
    runtime                        = "python3.9"
}