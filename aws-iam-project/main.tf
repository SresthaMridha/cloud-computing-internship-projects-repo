//creating an iam user
resource "aws_iam_user" "user" {
    name = var.iam_user_name
    force_destroy = true
}

//enabling console login
resource "aws_iam_user_login_profile" "user_login" {
    user = aws_iam_user.user.name
    password_reset_required = false
}

//craeting an iam group
resource "aws_iam_group" "group" {
    name = var.iam_group_name
}

//attach a policy to the group
resource "aws_iam_group_policy_attachment" "readOnlyPolicy" {
    group = aws_iam_group.group.name
    policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

//adding the user to the group
resource "aws_iam_group_membership" "membership" {
    name = "iam-group-membership"
    group = aws_iam_group.group.name
    users = [aws_iam_user.user.name]
}