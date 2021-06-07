### ENT EC2 Instance ###
module "ent-ec2-instance" {
  source                 = "../modules/ec2/"
  latest-ami-id          = "/GoldenAMI/RHEL-7/CISRHEL7Benchmark-1/latest"
  instance-type          = "t2.micro"
  iam-instance-profile   = "DefaultSSMInstanceProfile"
  vpc-security-group-ids = ["sg-018c79dbc3ed138b8"]
  subnet-id              = "subnet-705bdc1b"
  create-ebs-volume      = "true"
  instance-count         = "2"
  ebs-volume-size        = "10"
  user-data              = "IyEgL2Jpbi9iYXNoCnN1ZG8gYXdzIHMzIGNwIC0tcmVjdXJzaXZlIHMzOi8vcm9nZXJzLXVzZXJkYXRhLWludGVybmFsLXN0b3JhZ2UtMS9lYzJib290c3RyYXAuc2ggL3RtcC8Kc3VkbyBjaG1vZCA3NTUgL3RtcC9lYzJib290c3RyYXAuc2gKc291cmNlIC90bXAvZWMyYm9vdHN0cmFwLnNo"

  # Tagging variabless
  instance-name       = "demo-ent-rhel"
  businessunit        = "inf"
  data-classification = "internal"
  environment         = "sandbox"
  application-id      = "1234"
  application-name    = "tehchub"
  application-owner   = "anju"
  application-role    = "app"
  SCOA                = "123.1234.1234.1234.12345"
  project-id          = "123456"
  PII                 = "NO"
  compliance          = "None"
  otl-value           = "123456"
  task-code-value     = "1234"

}