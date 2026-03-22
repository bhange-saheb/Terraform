resource "null_resource" "cluster" {
  count = lookup(var.environment, var.region_name) == "Prod" ? 3 : 1

  provisioner "file" {
    source      = "user-data.sh"
    destination = "/tmp/user-data.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/KomalIDKey.pem")
      host        = element(aws_instance.FrontEnd-Server.*.public_ip, count.index)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/userdata.sh",
      "sudo /tmp/userdata.sh",
      "sudo apt update",
      "sudo apt install jq unzip -y",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("KomalIDKey.pem")
      host        = element(aws_instance.FrontEnd-Server.*.public_ip, count.index)
    }
  }
}
