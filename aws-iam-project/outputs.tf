output "iam_user_name" {
    value = aws_iam_user.user.name
}

output "iam_group_name" {
    value = aws_iam_group.group.name  
}

output "console_password" {
    value = aws_iam_user_login_profile.user_login.password  
    sensitive = true
}

output "iam_user_id" {
    value = aws_iam_user.user.id  
}