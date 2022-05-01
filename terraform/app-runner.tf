
# We just need to create once
# resource "aws_apprunner_connection" "voting" {
#   connection_name = "voting"
#   provider_type   = "GITHUB"

#   tags = {
#     Name = "review-apprunner-connection"
#   }
#}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_service
resource "aws_apprunner_service" "reviewapps" {
  service_name = "${var.name}-${var.stage}"
 
  source_configuration {
    authentication_configuration {
      # need to create mnually to get it here
      #connection_arn = aws_apprunner_connection.voting.arn
      connection_arn = "arn:aws:apprunner:eu-west-1:382076407153:connection/voting/c481aa8cc6794c9a9cc99c488f5ac7f8"
      #access_role_arn = 
    }
    code_repository {
      code_configuration {
        code_configuration_values {
          #build_command = "npm install"
          build_command = ["cd votingapp && pip install -r requirements.txt",
          "groupadd -r restaurantgroup && useradd -r -g restaurantgroup restaurantuser"]
          port          = var.port
          #runtime       = "NODEJS_12"
          runtime = "PYTHON_3"
          runtime_environment_variables = {
            "DDB_AWS_REGION" = "eu-west-1"
          }
          #start_command = "npm start"
          start_command = "python votingapp/app.py"
        }
        configuration_source = "API" # or REPOSITORY to use apprunner.yaml configuration file
      }
      #repository_url = "https://github.com/allamand/random-password-generator"
      #repository_url = "https://github.com/allamand/votingapp"
      repository_url = "https://github.com/allamand/apprunner-terraform"
      source_code_version {
        type  = "BRANCH"
        value = var.branch
      }
    }
    # image_repository {
    #   image_configuration {
    #       port          = var.port
    #       runtime_environment_variables = {
    #         "key" = "value"
    #       }
    #       start_command = "npm start"        
    #   }
    #   image_identifier = "name"
    #   image_repository_type = "ECR"
    # }
  }

  # network_configuration {
  #   egress_configuration {
  #     egress_type       = "VPC"
  #     vpc_connector_arn = aws_apprunner_vpc_connector.connector.arn
  #   }
  # }
 
  tags = {
    Name = "reviewapps-apprunner-service"
  }
}