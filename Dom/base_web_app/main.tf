resource "aws_instance" "web_server" {
    name = "web-server"
    ebs_volume {
        size = 40
    }
}

// TERRAFORM OBJECT REFERENCE
// <resource_type>.<name_label>.<attribute>
//Above example: aws_instance.web_server.name

