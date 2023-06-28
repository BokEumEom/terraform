locals {
  all_ec2 = {
    water-prod-app-tomcat01 = {
      InstanceId   = "i-xxxxxx"
      ImageId      = "ami-xxxxxx"
      InstanceType = "t3.small"
      device       = "nvme1n1"
      fstype       = "xfs"
      path         = "/water"
      pid_finder   = "native"
      pidfile      = "/water/tomcat/temp/tomcat.pid"
      exe          = "httpd"
    }

    water-prod-app-tomcat02 = {
      InstanceId   = "i-xxxxxxx"
      ImageId      = "ami-xxxxx"
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
