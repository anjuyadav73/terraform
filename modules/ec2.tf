### Parameters Data sources ###

data "aws_ssm_parameter" "instance-type" {
  name = "/ec2/instancetype/${var.instance-type}"
}

data "aws_ssm_parameter" "iam-instance-profile" {
  name = "/ec2/instanceprofile/${var.iam-instance-profile}"
}

data "aws_ssm_parameter" "latest-ami-id" {
  name = "${var.latest-ami-id}"
}

### Pull the availabily zone from instance ###
data "aws_instance" "instance-availability-zone" {
  count       = var.instance-count
  instance_id = aws_instance.ec2-instance[count.index].id

  depends_on = [aws_instance.ec2-instance]

}

### EC2 instance ####
resource "aws_instance" "ec2-instance" {
  count                  = var.instance-count
  ami                    = data.aws_ssm_parameter.latest-ami-id.value
  instance_type          = data.aws_ssm_parameter.instance-type.value
  iam_instance_profile   = var.iam-instance-profile
  availability_zone      = var.availability-zone == "" ? null : var.availability-zone
  vpc_security_group_ids = var.vpc-security-group-ids
  subnet_id              = var.subnet-id
  user_data_base64       = var.user-data

  tags = {
    Name                = "${var.instance-name}-${count.index + 1}"
    environment         = var.environment
    project-id          = var.project-id
    application-owner   = var.application-owner
    data-classification = var.data-classification
    application-id      = var.application-id
    application-role    = var.application-role
    application-name    = var.application-name
    PII                 = var.PII
    compliance          = var.compliance
    SCOA                = var.SCOA
    TFE                 = var.TFE
    businessunit        = var.businessunit
    otl-value           = var.otl-value
    task-code-value     = var.task-code-value
  }

}

## Elastic Block Store Volume ##

resource "aws_ebs_volume" "ec2-ebs-volume" {
  count             = var.create-ebs-volume == "true" ? var.instance-count : 0
  availability_zone = data.aws_instance.instance-availability-zone[count.index].availability_zone
  encrypted         = true
  size              = var.ebs-volume-size
  type              = var.ebs-volume-type

  tags = {
    Name                = "${var.instance-name}-${count.index + 1}"
    environment         = var.environment
    project-id          = var.project-id
    application-owner   = var.application-owner
    data-classification = var.data-classification
    application-id      = var.application-id
    application-role    = var.application-role
    application-name    = var.application-name
    PII                 = var.PII
    compliance          = var.compliance
    SCOA                = var.SCOA
    TFE                 = var.TFE
    businessunit        = var.businessunit
    otl-value           = var.otl-value
    task-code-value     = var.task-code-value
  }

  depends_on = [aws_instance.ec2-instance]

  lifecycle {
    ignore_changes = [
      availability_zone
    ]
  }
}

### EBS volume attachment to EC2 instance ###

resource "aws_volume_attachment" "ebs-volume-attachment" {
  count       = var.create-ebs-volume == "true" ? var.instance-count : 0
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ec2-ebs-volume[count.index].id
  instance_id = aws_instance.ec2-instance[count.index].id

  depends_on = [
    aws_ebs_volume.ec2-ebs-volume
  ]

  lifecycle {
    ignore_changes = [
      volume_id
    ]
  }
}