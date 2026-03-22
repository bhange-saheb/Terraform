resource "null_resource" "cluster" {
  count = var.environment == "Prod" ? 3 : 1

  provisioner "file" {
    source      = "../user-data.sh"
    destination = "/tmp/user-data.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("../XXXXKey.pem")
      host        = element(module.Prod_ec2.ec2_public_ip, count.index)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/user-data.sh",
      "sudo /tmp/user-data.sh",
      "sudo apt update",
      "sudo apt install jq unzip -y",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("../XXXXKey.pem")
      host        = module.Prod_ec2.ec2_public_ip[count.index]
    }
  }
}
