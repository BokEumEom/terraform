locals {
  all_ec2 = {
    water-prod-app-tomcat01 = {
      InstanceId   = "i-076e85d44c1cfd980"
      ImageId      = "ami-0a0064415cdedc552"
      InstanceType = "t3.small"
      device       = "nvme1n1"
      fstype       = "xfs"
      path         = "/water"
      pid_finder   = "native"
      pidfile      = "/water/tomcat/temp/tomcat.pid"
      exe          = "httpd"
    }

    water-prod-app-tomcat02 = {
      InstanceId   = "i-0b68772a13cc26b13"
      ImageId      = "ami-06210da7f5863a272"
      InstanceType = "t3.small"
      device       = "nvme1n1"
      fstype       = "xfs"
      path         = "/water"
      pid_finder   = "native"
      pidfile      = "/water/tomcat/temp/tomcat.pid"
      exe          = "httpd"
    }
  }
}