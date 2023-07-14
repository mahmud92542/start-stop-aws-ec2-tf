resource "aws_iam_policy" "sgp-uat-policy-lbd-start-stop-ec2" { 
    name         = "sgp-uat-policy-lbd-start-stop-ec2"
    path         = "/"
    description  = "Policy for Lambda function to control start and stop of EC2 instances"
    policy       = "${file("sgp-uat-policy-lbd-start-stop-ec2.json")}"
}


resource "aws_iam_role" "sgp-uat-role-lbd-start-stop-ec2" {
    name        = "sgp-uat-role-lbd-start-stop-ec2"
    path        = "/"
    description = "Allows Lambda function to control start and stop of EC2 instances."
    assume_role_policy = "${file("sgp-uat-role-lbd-start-stop-ec2.json")}"
}


resource "aws_iam_policy_attachment" "attach_iam_policy_to_iam_role" {
    name       = "attach_iam_policy_to_iam_role"
    roles      = ["${aws_iam_role.sgp-uat-role-lbd-start-stop-ec2.name}"]
    policy_arn = "${aws_iam_policy.sgp-uat-policy-lbd-start-stop-ec2.arn}"
}
