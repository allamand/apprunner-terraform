
resource "aws_apprunner_connection" "example" {
  connection_name = "example"
  provider_type   = "GITHUB"

  tags = {
    Name = "example-apprunner-connection"
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_service
resource "aws_apprunner_service" "reviewapps" {
  service_name = "${var.name}-${var.stage}"
 
  source_configuration {
    authentication_configuration {
      # need to create mnually to get it here
      connection_arn = aws_apprunner_connection.example.arn
    }
    code_repository {
      code_configuration {
        code_configuration_values {
          build_command = "npm install"
          port          = var.port
          runtime       = "NODEJS_12"
          start_command = "npm start"
        }
        configuration_source = "API"
      }
      repository_url = "https://github.com/allamand/random-password-generator"
      source_code_version {
        type  = "BRANCH"
        value = var.branch
      }
    }
  }
 
  tags = {
    Name = "reviewapps-apprunner-service"
  }
}