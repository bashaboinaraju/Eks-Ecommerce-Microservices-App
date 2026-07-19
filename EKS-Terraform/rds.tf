resource "aws_db_instance" "rds" {
  identifier             = "microservices-rds"

  engine                 = "mysql"
  engine_version         = "8.4.8"

  instance_class         = "db.t3.micro"

  allocated_storage      = 20
  storage_type           = "gp2"

  db_name                = "mydb"
  username               = "admin"
  password               = "Cloud123"

  db_subnet_group_name   = aws_db_subnet_group.sub-grp.name
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  # Free Tier
  multi_az               = false
  publicly_accessible    = false
  backup_retention_period = 0
  skip_final_snapshot    = true

  deletion_protection    = false

  tags = {
    Name = "microservices-rds"
  }

  depends_on = [
    aws_db_subnet_group.sub-grp
  ]
}

resource "aws_db_subnet_group" "sub-grp" {
  name = "main"

  subnet_ids = [
    aws_subnet.private1.id,
    aws_subnet.private2.id
  ]

  tags = {
    Name = "My DB Subnet Group"
  }
}